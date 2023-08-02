import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiligrim/models/user.dart';
import 'package:tiligrim/repository/chat_repo.dart';

part 'friend_changes_event.dart';
part 'friend_changes_state.dart';

class FriendChangesBloc extends Bloc<FriendChangesEvent, FriendChangesState> {

  final ChatRepository _chatRepository;

  FriendChangesBloc(this._chatRepository) : super(FriendChangesInitial()) {

    on<WatchFriend>((event, emit) {

      return emit.forEach(
        _chatRepository.friendStream(event.email),
        onData: (data) {
          final friend = data.data();
          return FriendChanged(UserModel.fromJson(friend!));
        }
      );

    });

  }
}
