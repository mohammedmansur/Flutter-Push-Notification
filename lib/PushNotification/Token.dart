import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                    subtitle: Text(productList[index].token ?? 'no token'),
                    trailing: Text('Send Direct Notification'),
                    tileColor: Color.fromARGB(255, 169, 53, 247),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const SimpleDialog(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'name',
                                  ),
                                )
                              ],
                            );
                          });
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
