import 'package:bookstore/auth/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utilities/util.dart';
import '../screens/MainScreen.dart';
import '../reuseable/reuseable.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
            begin: Alignment.topCenter, end: Alignment.bottomCenter
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,120, 20, 10),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                reuseableTextField("Enter UserName", Icons.person_outline, false, _userNameTextController),
                const SizedBox(height: 20,), // SizedBox
                reuseableTextField("Enter Email ID", Icons.person_outline, false, _emailTextController),
                const SizedBox(height: 20,), // SizedBox
                reuseableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                const SizedBox(height: 20,), // SizedBox
              Container(
                width: MediaQuery.of (context).size.width,
                height: MediaQuery.of (context).size.height*0.3,
                margin: const EdgeInsets. fromLTRB(0, 10, 0, 20),
                decoration: BoxDecoration (borderRadius: BorderRadius.circular (90)),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: ()async{

                        FirebaseAuth _auth = FirebaseAuth.instance;
                        String email = _emailTextController.text;
                        String password = _passwordTextController.text;
                        print("$email $password");

                        try {
                          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print("User registered: ${userCredential.user?.uid}");
                          // ignore: use_build_context_synchronously
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BookstoreHomePage()));
                        } catch (e) {
                          print("Error registering user: $e");
                          setState(() {
                            showError = true;
                          });
                          print(showError);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if(states.contains (MaterialState.pressed)) {
                              return Colors.black26;
                            }
                            return Colors.white;
                          }),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder (borderRadius: BorderRadius.circular (30))
                          )
                      ),
                      child: const Text(
                         'SIGN UP',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,5, 0,5),
                      child: Visibility(
                        visible: showError, // Set this to the value that controls visibility.
                        child: Text(
                          "Error Signing Up User",
                          style: TextStyle(fontSize: 21,color: Colors.red[900]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),

              ),
                signUpOption(context, false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
