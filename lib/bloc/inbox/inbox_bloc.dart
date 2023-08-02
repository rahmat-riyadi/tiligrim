import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiligrim/repository/chat_repo.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {

  final ChatRepository _chatRepository;

  InboxBloc(this._chatRepository) : super(InboxInitial()) {

    on<LoadInbox>((event, emit) {

      emit(InboxLoading());

      return emit.forEach(
        _chatRepository.chatStream(event.email),
        onData: (data) => InboxLoaded(data),
        onError: (Object object,StackTrace stackTrace) => InboxFailure()
      );

    });

  }
}
