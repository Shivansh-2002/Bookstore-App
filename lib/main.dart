import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../MainScreen.dart';
import '../util.dart';
import 'dart:convert';

void main() {
  runApp(BookstoreApp());
}
class BookstoreApp extends StatelessWidget {
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

