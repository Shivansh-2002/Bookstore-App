import 'package:flutter/material.dart';
import '../MainScreen.dart';

void main() {
  runApp(BookstoreApp());
}
class BookstoreApp extends StatelessWidget {
  const BookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Bookstore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,

      home: BookstoreHomePage(),
    );
  }
}

