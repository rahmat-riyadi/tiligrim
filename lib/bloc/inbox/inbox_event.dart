part of 'inbox_bloc.dart';

abstract class InboxEvent extends Equatable {
  const InboxEvent();

  @override
  List<Object> get props => [];
}

class LoadInbox extends InboxEvent {

  final String email;

  const LoadInbox(this.email);

  @override
  List <Object> get props => [email];

}


class InboxWatch extends InboxEvent {

  final String email;

  const InboxWatch(this.email);

  @override
  List <Object> get props => [email];

}

class InboxFriendWatch extends InboxEvent {

  final String email;

  const InboxFriendWatch(this.email);

  @override
  List <Object> get props => [email];

}
