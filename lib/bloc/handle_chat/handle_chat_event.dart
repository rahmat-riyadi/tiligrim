part of 'handle_chat_bloc.dart';

abstract class HandleChatEvent extends Equatable {
  const HandleChatEvent();

  @override
  List<Object> get props => [];
}

class SendChat extends HandleChatEvent {

  final String userEmail;
  final String friendEmail;
  final String text;
  final String conversationId;

  const SendChat({ required this.text, required this.friendEmail, required this.userEmail, required this.conversationId });

  @override
  List<Object> get props => [userEmail, friendEmail, text, conversationId];

}

class WatchChatRoom extends HandleChatEvent {

  final String conversationId;

  const WatchChatRoom(this.conversationId);

  @override
  List<Object> get props => [conversationId];

}
