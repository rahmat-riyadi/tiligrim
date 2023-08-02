part of 'friend_changes_bloc.dart';

abstract class FriendChangesState extends Equatable {
  const FriendChangesState();
  
  @override
  List<Object> get props => [];
}

class FriendChangesInitial extends FriendChangesState {}

class FriendChanged extends FriendChangesState {

  final UserModel friend;

  const FriendChanged(this.friend);

  @override
  List<Object> get props => [friend];

}