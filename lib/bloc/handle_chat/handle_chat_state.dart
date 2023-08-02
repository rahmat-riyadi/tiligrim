part of 'handle_chat_bloc.dart';

abstract class HandleChatState extends Equatable {
  const HandleChatState();
  
  @override
  List<Object> get props => [];
}

class HandleChatInitial extends HandleChatState {}
