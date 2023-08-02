
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiligrim/models/user.dart';
import 'package:tiligrim/repository/authentication_repo.dart';
import 'package:tiligrim/repository/database_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;

  AuthenticationBloc(this._authenticationRepository, this._databaseRepository) : super(AuthenticationInitial()) {

    on<AuthenticationSubmit>((event, emit) async {

      emit(AuthenticationLoading());

      try {

        final res = await _authenticationRepository.signIn();
        final userExist = await _databaseRepository.checkUser(res!.user!.email.toString());

        final UserModel user = UserModel(
          email: res.user!.email.toString(), 
          displayName: res.user!.displayName.toString(), 
          photoUrl: res.user!.photoURL.toString(), 
          id: res.user!.uid,
          isActive: true,
          chats: []
        );

        if(!userExist){
          _databaseRepository.addData(user);
        } 

        final userData = await _databaseRepository.getData(res.user!.email.toString());
        final userLogin = userData.data();

        final userChat = await _databaseRepository.getChats(res.user!.email.toString());

        if(userChat.docs.isEmpty){
          emit(AuthenticationSuccess(
            UserModel(
              email: userLogin!['email'], 
              displayName: userLogin['displayName'], 
              photoUrl: userLogin['photoUrl'], 
              id: userLogin['id'], 
              chats: []
            ))
          );

        } else {

          List<ChatUser> chat = [];
          userChat.docs.forEach((element) {

            var elementData = element.data();
            var chatId = element.id;

            chat.add(
              ChatUser(
                email: elementData['connection'], 
                conversationId: chatId, 
                lastTime: DateTime.parse(elementData['lastTime']), 
                totalUnread: elementData['total_unread'],
                lastChat: elementData['lastChat'],
              )
            );

          });

          emit(AuthenticationSuccess(
            UserModel(
              email: userLogin!['email'], 
              displayName: userLogin['displayName'], 
              photoUrl: userLogin['photoUrl'], 
              id: userLogin['id'], 
              chats: chat
            ))
          );

        }

      } on FirebaseAuthException catch (e){
        emit(AuthenticationFailure(e.code));
      }
      
    });

    on<AuthenticationCheck>((event, emit) async {

      try {

        final isSignIn = await _authenticationRepository.isSignIn();

        if(!isSignIn){
          emit(AuthenticationInitial());
        } else {
          final res = await _authenticationRepository.checkUser();
          final UserModel user = UserModel(
            email: res!.email.toString(), 
            displayName: res.displayName.toString(), 
            photoUrl: res.photoURL.toString(), 
            id: res.uid,
            chats: []
          ); 
          emit(AuthenticationSuccess(user));
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthenticationFailure(e.code));
      }

    });

    on<AuthenticationEvent>((event, emit) {
      _authenticationRepository.signOut();
      emit(AuthenticationLoggedOut());
    });

  }
}
