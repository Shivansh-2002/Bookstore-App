import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/MainScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utilities/api_call_state.dart';

// I am just calling the functions here which i have declared in different files and explained it there.
// please go through the whole code :)



//Main Function going to run App Bookstore
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyBu5Pt19_gWCxPX97Xk35lsjkXCI5sb684",
        appId: "1:653922675269:web:27fd1e91b3ad96cfe2d12c",
        messagingSenderId: "653922675269",
        projectId: "bookzone-388c9")
    );
  }

  await Firebase.initializeApp();
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
      home: const BookstoreHomePage(),
    );
  }
}

