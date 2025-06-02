import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

final _firebase = FirebaseAuth.instance;
var logger = Logger();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    try {
      final userCred = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
      logger.i(userCred);
      // Optionally navigate to another screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (error) {
      logger.e(error.message);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message?.substring(0, 20) ?? 'Authentication failed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset("assets/images/unlock.png", width: 150, height: 50),
                const SizedBox(height: 50),
                Text(
                  "Create an account",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 42),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.trim().contains('@')) {
                                return 'Enter a valid email address!!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredEmail = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty || value.length < 5) {
                                return 'Password must be at least 5 characters long!!';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _enteredPassword = value;
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredPassword = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) {
                              if (value != _enteredPassword) {
                                return 'Passwords do not match!!';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                    textStyle: GoogleFonts.poppins(color: Colors.black),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Sign Up", style: GoogleFonts.poppins(color: Colors.black)),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'I already have an account',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
