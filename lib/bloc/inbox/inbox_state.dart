part of 'inbox_bloc.dart';

abstract class InboxState extends Equatable {
  const InboxState();
  
  @override
  List<Object> get props => [];
}

class InboxInitial extends InboxState {}

class InboxLoaded extends InboxState {
  final dynamic chats;

  const InboxLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

class InboxLoading extends InboxState {}

class InboxFailure extends InboxState {}

class FriendInboxLoaded extends InboxState {
  final dynamic user;

  const FriendInboxLoaded(this.user);

  @override
  List<Object> get props => [user];
}
