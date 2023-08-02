import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiligrim/bloc/authentication/authentication_bloc.dart';
import 'package:tiligrim/bloc/chat/chat_bloc.dart';
import 'package:tiligrim/bloc/conversation/conversation_bloc.dart';
import 'package:tiligrim/bloc/friend/friend_bloc.dart';
import 'package:tiligrim/bloc/friend_changes/friend_changes_bloc.dart';
import 'package:tiligrim/bloc/handle_chat/handle_chat_bloc.dart';
import 'package:tiligrim/bloc/inbox/inbox_bloc.dart';
import 'package:tiligrim/pages/home.dart';
import 'package:tiligrim/pages/login.dart';
import 'package:tiligrim/repository/authentication_repo_impl.dart';
import 'package:tiligrim/repository/chat_repo_impl.dart';
import 'package:tiligrim/repository/database_repo_impl.dart';
import 'package:tiligrim/utils/pallete.dart';
import 'package:tiligrim/utils/route_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(AuthenticationRepositoryImpl(), DatabaseRepositoryImpl())..add(AuthenticationCheck())
        ),
        BlocProvider<InboxBloc>(
          create: (context) => InboxBloc(ChatRepositoryImpl()),
        ),
        BlocProvider<FriendBloc>(
          create: (context) => FriendBloc(DatabaseRepositoryImpl()),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(ChatRepositoryImpl()),
        ),
        BlocProvider<FriendChangesBloc>(
          create: (context) => FriendChangesBloc( ChatRepositoryImpl()),
        ),
        BlocProvider<HandleChatBloc>(
          create: (context) => HandleChatBloc(ChatRepositoryImpl()),
        ),
        BlocProvider<ConversationBloc>(
          create: (context) => ConversationBloc(ChatRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tiligrim',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
            primaryColor: Pallete.primary, primaryColorDark: Pallete.primary),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {

            if(state is AuthenticationFailure || state is AuthenticationLoggedOut || state is AuthenticationInitial){
              return const LoginScreen();
            }
              // return LoginScreen();
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
