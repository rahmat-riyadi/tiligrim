import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiligrim/repository/chat_repo.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {

  final ChatRepository _chatRepository;

  ConversationBloc(this._chatRepository) : super(ConversationInitial()) {
    
    on<WatchConversation>((event, emit) {
      return emit.forEach(
        _chatRepository.getConversation(event.conversationId), 
        onData: (data) => ConversationLoaded(data)
      );
    });

  }
}
