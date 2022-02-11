import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pushnot/PushNotification/dataModel.dart';

class Token extends StatefulWidget {
  const Token({Key? key}) : super(key: key);

  @override
  _TokenState createState() => _TokenState();
}

class _TokenState extends State<Token> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pop(context));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () {
            snedNotiDialog('Send to All');
          },
          child: Text('send notification')),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('test').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            List<DocumentSnapshot> _docs = snapshot.data!.docs;

            List<Users> productList = _docs
                .map((e) => Users.fromMap(e.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      title: Text(productList[index].name ?? 'no name'),
                      subtitle: productList[index].token != null
                          ? const Text('Ready To interact')
                          : const Text('not have token'),
                      trailing: const Text('Send Direct Notification'),
                      tileColor: Color.fromARGB(255, 188, 128, 228),
                      onTap: () {
                        snedNotiDialog('Sending Direct Nitification');
                      }),
                );
              },
            );
          },
        ),
      ),
    );
  }

// Text(productList[index].token ?? 'no token')
  snedNotiDialog(String title) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(title),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'name',
                      ),
                    ),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'body',
                      ),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(Icons.send),
                  ],
                ),
              )
            ],
          );
        });
  }
}
