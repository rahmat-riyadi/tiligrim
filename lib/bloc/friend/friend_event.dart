part of 'friend_bloc.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object> get props => [];
}

class LoadFriend extends FriendEvent {

  final String id;

  const LoadFriend(this.id);

  @override
  List<Object> get props => [id];

}