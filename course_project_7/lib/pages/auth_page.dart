import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

final firebase = FirebaseAuth.instance; // global variable
final logger = Logger();

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = false;
  var enteredPassword = '';
  var enteredEmail = '';
  var enteredUserName = '';

  final formKey = GlobalKey<FormState>();
  void submitForm() async {
    bool isValid = formKey.currentState!.validate();
    try {
      if (isValid) {
        formKey.currentState!.save();
        if (isLogin) {
          final existingUserCredentials = await firebase
              .signInWithEmailAndPassword(
                email: enteredEmail,
                password: enteredPassword,
              );
          logger.i(existingUserCredentials);
        } else {
          logger.i("$enteredEmail $enteredPassword");
          final userCred = await firebase.createUserWithEmailAndPassword(
            email: enteredEmail,
            password: enteredPassword,
          );
          logger.i(userCred);

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCred.user!.uid)
              .set({"username": enteredUserName, "email": enteredEmail});
        }
      } else {
        return;
      }
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication Failed!!")),
        );
        logger.e(error.message);
      } else {
        logger.e("context is not mounted");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Text(
              "Ding Dong",
              style: GoogleFonts.mochiyPopOne(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 246, 225, 218),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
              child: Image.asset(
                'assets/images/chat.png',
                height: 100,
                width: 100,
              ),
            ),

            Card(
              elevation: 5,
              color: Colors.black45,
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 246, 225, 218),
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              "Email address",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 246, 225, 218),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return "enter a valid email address!!";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredEmail = value!;
                          },
                        ),
                        if (!isLogin) const SizedBox(height: 10),
                        if (!isLogin)
                          TextFormField(
                            style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 246, 225, 218),
                            ),
                            decoration: InputDecoration(
                              label: Text(
                                "Username",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 246, 225, 218),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 4) {
                                return "username must atleast 4 characters long";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredUserName = value!;
                            },
                          ),
                        const SizedBox(height: 10),
                        TextFormField(
                          style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 246, 225, 218),
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              "Password",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 246, 225, 218),
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.length < 5 ||
                                value.trim().isEmpty) {
                              return "password must atleast 5 characters long!!";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredPassword = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                          ),
                          child: Text(
                            isLogin ? "Login" : "Sign up",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 246, 225, 218),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin
                                ? 'Create an account'
                                : 'I already have an account',
                            style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 246, 225, 218),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
