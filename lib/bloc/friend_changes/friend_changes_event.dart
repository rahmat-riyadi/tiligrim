part of 'friend_changes_bloc.dart';

abstract class FriendChangesEvent extends Equatable {
  const FriendChangesEvent();

  @override
  List<Object> get props => [];
}

class WatchFriend extends FriendChangesEvent {

  final String email;

  const WatchFriend(this.email);

  @override
  List<Object> get props => [email];  

}
