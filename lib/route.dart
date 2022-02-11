import 'package:flutter/material.dart';
import 'package:pushnot/PushNotification/Register.dart';
import 'package:pushnot/PushNotification/Token.dart';

class Routing extends StatelessWidget {
  const Routing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Register(),
        '/token': (context) => const Token(),
      },
    );
  }
}
