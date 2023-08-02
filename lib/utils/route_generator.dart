import 'package:flutter/material.dart';
import 'package:tiligrim/pages/chat_room.dart';
import 'package:tiligrim/pages/home.dart';
import 'package:tiligrim/pages/login.dart';
import 'package:tiligrim/pages/register.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments as dynamic;
    
    switch (settings.name) {
      case '/register':
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/chatRoom':
        return MaterialPageRoute(builder: (context) => ChatRoom(args: args));
      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }

  }

}