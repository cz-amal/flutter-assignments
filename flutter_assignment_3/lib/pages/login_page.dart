import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_3/pages/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';

var logger = Logger();
final _firebase = FirebaseAuth.instance;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message?.substring(0, 20) ?? 'Authentication failed.')),
        );
      }
    }

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
                // login to your page
                Text(
                  "Login to your account",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // card for login
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
                              enteredEmail = value!;
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
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
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
                // login button
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

                // already have account
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

                TextButton(
                  onPressed: () {},
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
