import 'package:flutter/material.dart';
import '../MainScreen.dart';

// I am just calling the functions here which i have declared in different files and explained it there.
// please go through the whole code :)



//Main Function going to run App Bookstore
void main() {
  runApp(const BookstoreApp());
}
// Function Book store app which uses different function made present in the different code files
class BookstoreApp extends StatelessWidget {
  const BookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ideal basic app implementation
    return MaterialApp(
      title: 'Bookstore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // the home page which contain all the information
      home: const BookstoreHomePage(),
    );
  }
}

