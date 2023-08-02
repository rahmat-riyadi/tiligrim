part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class WatchConversation extends ConversationEvent {

  final String conversationId;

  const WatchConversation(this.conversationId);

  @override
  List<Object> get props => [conversationId];

}
