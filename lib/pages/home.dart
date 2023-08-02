import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiligrim/bloc/authentication/authentication_bloc.dart';
import 'package:tiligrim/bloc/friend/friend_bloc.dart';
import 'package:tiligrim/bloc/inbox/inbox_bloc.dart';
import 'package:tiligrim/components/drawer.dart';
import 'package:tiligrim/components/friend_list_bottom_sheet.dart';
import 'package:tiligrim/components/inbox_list.dart';
import 'package:tiligrim/components/shimmer_list.dart';
import 'package:tiligrim/models/user.dart';
import 'package:tiligrim/repository/chat_repo.dart';
import 'package:tiligrim/repository/chat_repo_impl.dart';
import 'package:tiligrim/utils/pallete.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatRepository _chatRepository = ChatRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        state as AuthenticationSuccess;
        context.read<InboxBloc>().add(LoadInbox(state.user.email));
        context.read<FriendBloc>().add(LoadFriend(state.user.id));

        final userEmail = state.user.email;

        return Scaffold(
          drawer: const DrawerComponent(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
                builder: (context) =>
                    FriendListBottomSheet(userEmail: userEmail),
              );
            },
            backgroundColor: Pallete.primary,
            child: const Icon(Icons.edit),
          ),
          appBar: AppBar(
            backgroundColor: Pallete.primary,
            elevation: 0,
            title: const Text('Tiligrim'),
          ),
          body: Container(
            // color: const Color(0xffEEEEEE),
            color: Colors.white,
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<InboxBloc>().add(LoadInbox(state.user.email));
                context.read<FriendBloc>().add(LoadFriend(state.user.id));
              },
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 25, top: 20, bottom: 10),
                          child: Text(
                            'Inbox',
                            style: TextStyle(
                                color: Pallete.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _chatRepository.chatStream(userEmail),
                          builder: (context, snapshot) {
                            
                            if(snapshot.connectionState != ConnectionState.active){
                              return Column(
                                  children: List.generate(5, (index) => const ShimmerList()),
                              );
                            }

                            List<dynamic> friend = snapshot.data!.docs.map((e) => { 
                              'id': e.id, 
                              'inbox': ChatUser(
                                conversationId: e.id,
                                email: e.data()['connection'],
                                lastChat: e.data()['lastChat'],
                                lastTime: DateTime.parse(e.data()['lastTime']),
                                totalUnread: e.data()['total_unread'],
                              )
                            }).toList();

                            return Column(
                              children: friend.map((e) {
                                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                  stream: _chatRepository.friendStream(e['inbox'].email),
                                  builder: (context, snapshot) {
                                    dynamic friendData;
                                    if(snapshot.connectionState == ConnectionState.active){
                                      friendData = snapshot.data!.data();
                                    }
                                    return InboxListItem(
                                      friend: snapshot.connectionState == ConnectionState.active
                                      ?
                                      UserModel.fromJson(snapshot.data?.data() as Map<String, dynamic>)
                                      :
                                      UserModel(email: '', displayName: '', photoUrl: '', id: '', chats: []),
                                      chatUser: e['inbox'],
                                      onTap: () => Navigator.pushNamed(
                                        context, '/chatRoom',
                                        arguments: {
                                          'conversation_id': e['id'],
                                          'name': friendData!['displayName'],
                                          'avatar': friendData['photoUrl'],
                                          'email': friendData['email'],
                                          'userEmail': userEmail,
                                          'isFirst': false
                                        }
                                      )
                                    );
                                  }
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
