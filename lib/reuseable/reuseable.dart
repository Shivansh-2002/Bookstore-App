import 'package:flutter/material.dart';
import '../screens/MainScreen.dart';
import '../auth/signup.dart';
import '../auth/signin.dart';

TextField reuseableTextField(String text, IconData icon, bool isPasswordType, TextEditingController controller){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: isPasswordType,
    autocorrect: isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration (
      prefixIcon: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Icon(
          icon,
          color: Colors. white70,
        ),
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular (30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)
      ),
    ),
    keyboardType: isPasswordType ? TextInputType. visiblePassword:  TextInputType.emailAddress,
  );
}




Column signUpOption(BuildContext context, bool signin ) {
  return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text ((signin)?"Don't have account? ":"Already have an account ",
                style: const TextStyle(color: Colors.white70)),
            GestureDetector(
              onTap: () {
                (signin)?
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen())):
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()));
              },
              child: Text((signin)?"Sign Up":"LogIn", style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),


        const SizedBox(height: 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text ("Continue as ",
                style: TextStyle(color: Colors.white70)),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BookstoreHomePage()));
              },
              child: const Text("Guest", style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

      ]
  );
}
