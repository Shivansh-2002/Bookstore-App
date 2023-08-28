import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utilities/util.dart';
import '../reuseable/reuseable.dart';
import '../screens/MainScreen.dart';


class SignInScreen  extends StatefulWidget {
  const SignInScreen({Key?key}): super(key:key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height*(0.09), 20, 20),
              child: Column(
                children: [
                  const Text("BookWander",
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                        fontWeight: FontWeight.w600
                    )
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    width: 240,
                    height: 240
                  ),
                  const SizedBox(height: 30,),
                  reuseableTextField("Enter Email", Icons.person_outline, false, _emailTextController ),
                  const SizedBox(height: 20,), // SizedBox

                  reuseableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of (context).size.width,
                    height: MediaQuery.of (context).size.height*0.18,
                    margin: const EdgeInsets. fromLTRB(0, 10, 0, 20),
                    decoration: BoxDecoration (borderRadius: BorderRadius.circular (90)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: ()async{

                              print("I am here");
                              FirebaseAuth _auth = FirebaseAuth.instance;
                              String email = _emailTextController.text;
                              String password = _passwordTextController.text;
                              print(email+" "+password);

                              try {
                                UserCredential userCredential = await _auth.signInWithEmailAndPassword(
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
                            child: Text('LOG IN' ,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,3, 0,2),
                            child: Visibility(
                              visible: showError, // Set this to the value that controls visibility.
                              child: Text(
                                "Invalid email or password.",
                                style: TextStyle(fontSize: 18,color: Colors.red[900]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          signUpOption(context, true),
                        ],
                      ),
                    ),


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



