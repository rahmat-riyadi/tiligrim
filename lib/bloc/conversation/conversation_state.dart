part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();
  
  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final dynamic chat;

  const ConversationLoaded(this.chat);

  @override
  List<Object> get props => [chat];

}