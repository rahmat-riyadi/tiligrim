part of 'friend_bloc.dart';

abstract class FriendState extends Equatable {
  const FriendState();
  
  @override
  List<Object> get props => [];
}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendLoaded extends FriendState {

  final List<FriendModel> friends;

  const FriendLoaded(this.friends);

  @override
  List<Object> get props => [friends];

}


