import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  late CollectionReference notesRef;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    notesRef = FirebaseFirestore.instance.collection('notes');
    print('Current user UID: \\${user?.uid}');
  }

  Future<void> addNote(String text) async {
    final doc = await notesRef.add({
      'text': text,
      'userId': user?.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
    print('Added note: id=\\${doc.id}, userId=\\${user?.uid}, text=\\$text');
  }

  Future<void> updateNote(String noteId, String text) async {
    await notesRef.doc(noteId).update({'text': text});
  }

  Future<void> deleteNote(String noteId) async {
    await notesRef.doc(noteId).delete();
  }

  void showNoteDialog({String? noteId, String? initialText}) {
    final controller = TextEditingController(text: initialText ?? '');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(noteId == null ? 'Add Note' : 'Edit Note'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter your note'),
            minLines: 1,
            maxLines: 5,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final text = controller.text.trim();
                if (text.isEmpty) return;
                if (noteId == null) {
                  await addNote(text);
                } else {
                  await updateNote(noteId, text);
                }
                Navigator.of(context).pop();
              },
              child: Text(noteId == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body:
          user == null
              ? const Center(child: Text('Not logged in'))
              : StreamBuilder<QuerySnapshot>(
                stream:
                    notesRef
                        .where('userId', isEqualTo: user!.uid)
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  print('Query snapshot: \\${snapshot.data}');
                  final notes = snapshot.data?.docs ?? [];
                  print('Notes count: \\${notes.length}');
                  for (var n in notes) {
                    print('Note: id=\\${n.id}, data=\\${n.data()}');
                  }
                  if (notes.isEmpty) {
                    return const Center(child: Text('No notes yet. Tap + to add.'));
                  }
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return ListTile(
                        title: Text(note['text'] ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed:
                                  () => showNoteDialog(noteId: note.id, initialText: note['text']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await deleteNote(note.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
      floatingActionButton:
          user == null
              ? null
              : FloatingActionButton(
                onPressed: () => showNoteDialog(),
                child: const Icon(Icons.add),
              ),
    );
  }
}
