import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiligrim/models/friend.dart';
import 'package:tiligrim/repository/database_repo.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {

  final DatabaseRepository _databaseRepository;  

  FriendBloc(this._databaseRepository) : super(FriendInitial()) {

    on<LoadFriend>((event, emit) async {

      try {
        
        final res = await _databaseRepository.getUsers(event.id);
        List<FriendModel> friends = res.docs.map((e) => FriendModel.fromJson(e.data() as Map<String, dynamic>)).toList();
        emit(FriendLoaded(friends));

      } catch (e) {
        print('err :'+ e.toString());
        emit(const FriendLoaded([]));
      }

    });

  }
}
