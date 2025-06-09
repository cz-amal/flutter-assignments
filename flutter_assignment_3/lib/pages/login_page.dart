import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_3/pages/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/web.dart';

var logger = Logger();
final _firebase = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  var enteredEmail = '';
  var enteredPassword = '';

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    try {
      final userCred = await _firebase.signInWithEmailAndPassword(
        email: enteredEmail,
        password: enteredPassword,
      );
      logger.i(userCred);
      // Optionally navigate to another screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (error) {
      logger.e(error.message);
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message?.substring(0, 20) ?? 'Authentication failed.')),
      );
    }
  }

  void submitGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return;
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await _firebase.signInWithCredential(credential);
  }

  Future<void> showPasswordResetDialog(BuildContext context) async {
    String email = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset Password', style: GoogleFonts.poppins()),
          content: TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter your email address',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (email.trim().isNotEmpty && email.contains('@')) {
                  try {
                    await _firebase.sendPasswordResetEmail(email: email.trim());
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'If an account exists for this email, a password reset link has been sent. Please check your email.',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    logger.e(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to send reset link.', style: GoogleFonts.poppins()),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please enter a valid email address.',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                }
              },
              child: Text('Send', style: GoogleFonts.poppins()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
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
                  "Login to your account",
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
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 42),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            focusNode: emailFocusNode,
                            decoration: InputDecoration(
                              labelText: "Email",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(passwordFocusNode);
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.trim().contains('@')) {
                                return 'Enter a valid email address!!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredEmail = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            focusNode: passwordFocusNode,
                            decoration: InputDecoration(
                              labelText: "Password",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              submit();
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty || value.length < 5) {
                                return 'Password must be atleast 5 characters long!!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredPassword = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                    textStyle: GoogleFonts.poppins(color: Colors.black),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Login", style: GoogleFonts.poppins(color: Colors.black)),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: Text(
                    'I don\'t have an account',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or', style: GoogleFonts.poppins(color: Colors.black)),
                    ),
                    Expanded(child: Divider(color: Colors.black, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    submitGoogle();
                  },
                  icon: Image.asset('assets/images/google_icon.png', width: 24, height: 24),
                  label: Text(
                    'Sign in with Google',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    await showPasswordResetDialog(context);
                  },
                  child: Text('Forgot Password?', style: GoogleFonts.poppins(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
