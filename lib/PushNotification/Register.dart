import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pushnot/PushNotification/Notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pushnot/PushNotification/Token.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _controller = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static String? tokenCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notification'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'name'),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _firebaseAuth.signInAnonymously().then((value) {
                    _firebaseMessaging.getToken().then((token) {
                      setState(() {
                        tokenCode = token;
                      });
                      _firebaseFirestore
                          .collection('test')
                          .doc(value.user!.uid)
                          .set({
                        'uid': value.user!.uid,
                        'name': _controller.value.text,
                        'token': token,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Token()),
                      );
                      _controller.clear();
                    });
                  });
                },
                child: Text('signIn Anonymously')),
          ],
        ),
      ),
    );
  }
}
