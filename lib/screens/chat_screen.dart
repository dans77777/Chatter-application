import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemBuilder: (ctx, i) => Text('adding chats'),
          itemCount: 10,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Firestore.instance
                .collection('chats/KI9juBtoDD141S6oQU2A/messages')
                .snapshots()
                .listen((data) {
              print(data.documents[0]['text']);
            });
          },
          child: Icon(Icons.add),
        ));
  }
}
