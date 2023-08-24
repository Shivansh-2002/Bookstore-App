import 'package:bookstore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utilities/api_call_state.dart';
import 'auth/signin.dart';
// I am just calling the functions here which i have declared in different files and explained it there.
// please go through the whole code :)



//Main Function going to run App Bookstore
void main(){
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
        create: (_) => ApiCallState(), // Provide the ApiCallState instance
        child: const BookstoreApp(),
      ),
  );
}
// Function Book store app which uses different function made present in the different code files
class BookstoreApp extends StatelessWidget {
  const BookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ideal basic app implementation
    return MaterialApp(
      title: 'BookWander',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // the home page which contain all the information
      home: const SignInScreen(),
      // const BookstoreHomePage(),
    );
  }
}

