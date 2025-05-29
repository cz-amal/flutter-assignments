import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var messageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }

  void submitMessage() async {
    final message = messageController.text;
    if (message.trim().isEmpty) {
      return;
    }
    messageController.clear();
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    final userData =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    // send the message to firestore
    FirebaseFirestore.instance.collection('chats').add({
      "text": message,
      "createdAt": Timestamp.now(),
      "userId": user.uid,
      "userName": userData.data()!['username'],
    });


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 246, 225, 218),
              ),
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: "send a message.."),
            ),
          ),
          IconButton(
            onPressed: submitMessage,
            icon: Icon(Icons.send, color: Color.fromARGB(255, 246, 225, 218)),
          ),
        ],
      ),
    );
  }
}
