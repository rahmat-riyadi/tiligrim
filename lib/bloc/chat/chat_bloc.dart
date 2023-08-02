import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiligrim/repository/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final ChatRepository _chatRepository;

  ChatBloc(this._chatRepository) : super(ChatInitial()) {

    on<CreateChatEvent>((event, emit) async {
      emit(ChatLoading());
      await _chatRepository.createConversation(event.userEmail, event.friendEmail);
      emit(ChatCreated());
    });

  }
}
