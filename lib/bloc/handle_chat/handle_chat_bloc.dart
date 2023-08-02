import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiligrim/repository/chat_repo.dart';

part 'handle_chat_event.dart';
part 'handle_chat_state.dart';

class HandleChatBloc extends Bloc<HandleChatEvent, HandleChatState> {

  final ChatRepository _chatReposistory;

  HandleChatBloc(this._chatReposistory) : super(HandleChatInitial()) {

    on<SendChat>((event, emit){
      _chatReposistory.newChat(
        chatId: event.conversationId, 
        friendEmail: event.friendEmail, 
        userEmail: event.userEmail, 
        text: event.text
      );
    });
  }
}
