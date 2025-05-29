import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project_7/components/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('chats')
              .orderBy('createdAt', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "no messages",
              style: GoogleFonts.varelaRound(
                color: Color.fromARGB(255, 246, 225, 218),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "something went wrong!!",
              style: GoogleFonts.varelaRound(
                color: Color.fromARGB(255, 246, 225, 218),
              ),
            ),
          );
        }
        final loadedMessages = snapshot.data!.docs;
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40, left: 30, right: 30),
          reverse: true, // list goes from bottom to top
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage =
                index + 1 < loadedMessages.length
                    ? loadedMessages[index + 1].data()
                    : null;
            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;
            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
            return MessageBubble.first(
              username: chatMessage['username'],
              message: chatMessage['text'],
              isMe: authenticatedUser.uid == currentMessageUserId,
            );
          },
        );
      },
    );
  }
}
