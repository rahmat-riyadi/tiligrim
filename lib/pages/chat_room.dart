import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tiligrim/bloc/handle_chat/handle_chat_bloc.dart';
import 'package:tiligrim/components/bubble_chat.dart';
import 'package:tiligrim/models/chat.dart';
import 'package:tiligrim/repository/chat_repo_impl.dart';
import 'package:tiligrim/utils/pallete.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom({super.key, required this.args});

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, dynamic> args;

  final ChatRepositoryImpl _chatRepository = ChatRepositoryImpl();

  void _scrollView() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    FocusScopeNode currentFocus = FocusScope.of(context);

    if(!args['isFirst']){
      _chatRepository.readChat(args['conversation_id'], args['userEmail']);
    }

    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Pallete.primary,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(args['avatar'].toString()),
                onBackgroundImageError: (exception, stackTrace) =>
                    Text(args['name'].toString().substring(-1, 0)),
                backgroundColor: Colors.red,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    args['name'].toString(),
                    style: const TextStyle(fontSize: 19),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'Last seen',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bgChat.png'),
                        fit: BoxFit.cover)),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _chatRepository.getConversation(args['conversation_id']),
                  builder: (context, snapshot) {
                    List<dynamic> chats = [];

                    if(snapshot.connectionState == ConnectionState.active){
                      chats = snapshot.data!.docs.map((e) => Chat.fromJson(e.data())).toList();
                      _scrollView();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: chats.length,
                        itemBuilder: (context, index) => Padding(
                          padding: index == 0 ? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
                          child: BubbleChat(
                            text: chats[index].message, 
                            isSender: chats[index].sender == args['userEmail'],
                            time: DateFormat('HH:mm').format(chats[index].time),
                            isRead: chats[index].isRead
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_rounded,
                        color: Pallete.primary,
                        size: 30,
                      )),
                  Expanded(
                      child: Container(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )),
                  IconButton(
                    onPressed: () {
                      if(_textEditingController.text.isEmpty){
                        return;
                      }
                      context.read<HandleChatBloc>().add(
                        SendChat(
                          text: _textEditingController.text,
                          friendEmail: args['email'],
                          userEmail: args['userEmail'],
                          conversationId: args['conversation_id']
                        )
                      );
                      _scrollView();
                      _textEditingController.clear();
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Pallete.primary,
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
