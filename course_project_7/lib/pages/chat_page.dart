import 'package:course_project_7/components/messages.dart';
import 'package:course_project_7/components/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';


var logger = Logger();
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  void setUpNotification() async{
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    logger.i(token);
    fcm.subscribeToTopic('chats');

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpNotification();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Chats",
          style: GoogleFonts.mochiyPopPOne(
            color: Color.fromARGB(255, 246, 225, 218),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(255, 246, 225, 218),
            ),
          ),
        ],
      ),
      body: Column(children: [Expanded(child: Messages()), NewMessage()]),
    );
  }
}
