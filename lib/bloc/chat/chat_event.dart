part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class CreateChatEvent extends ChatEvent {

  final String userEmail;
  final String friendEmail;

  const CreateChatEvent({required this.userEmail, required this.friendEmail});

  @override
  List<Object> get props => [userEmail, friendEmail];

}

class LoadChatEvent extends ChatEvent {

  final String id;

  const LoadChatEvent(this.id);

  @override
  List<Object> get props => [id];

}