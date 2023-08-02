import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiligrim/bloc/friend/friend_bloc.dart';
import 'package:tiligrim/components/chat_list.dart';
import 'package:tiligrim/components/shimmer_list.dart';
import 'package:tiligrim/models/friend.dart';
import 'package:tiligrim/repository/chat_repo.dart';
import 'package:tiligrim/repository/chat_repo_impl.dart';
import 'package:tiligrim/utils/pallete.dart';

class FriendListBottomSheet extends StatelessWidget {
  
  FriendListBottomSheet({super.key, required this.userEmail});

  final String userEmail;

  final ChatRepository _chatRepository = ChatRepositoryImpl();

  @override
  Widget build(BuildContext context) {

    List<FriendModel> friends = [];

    return ClipRRect(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Orang Orang Di Tiligrim',
              style: TextStyle(
                  color: Pallete.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const  SizedBox(height: 20),
            BlocBuilder<FriendBloc, FriendState>(
              builder: (context, state) {

                if(state is FriendLoading){
                  return Column(
                    children: List.generate(5, (index) => const ShimmerList()),
                  );
                }

                // state as FriendLoaded;
                if(state is FriendLoaded){
                  friends = state.friends;
                }

                return Column(
                  children: friends.map((friend) => FriendListItem(
                    user: friend, 
                    onTap: () {
                      _chatRepository.createConversation(userEmail, friend.email)
                      .then((value){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/chatRoom', arguments: {
                          "avatar": friend.photoUrl,
                          "name": friend.displayName,
                          "userEmail": userEmail,
                          "conversation_id":value,
                          "email": friend.email,
                          "isFirst": true
                        });
                      });
                    }
                  )).toList()
                );


              },
            )
          ],
        ),
      ),
    );
  }
}
