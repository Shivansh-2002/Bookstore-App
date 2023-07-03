import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../MainScreen.dart';
import '../util.dart';
import 'dart:convert';


class BookDetailPage extends StatefulWidget {
  // Define any necessary parameters to pass data to the book detail page
  final String bookId;
  final List<Book> genreBook;
  BookDetailPage({required this.bookId, required this.genreBook});
  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for the book detail page
    return Scaffold(
      appBar: AppBar(
        title: Text('        Books in ${widget.bookId}'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: widget.genreBook.map((xx) => buildBookCard(xx, CardSize.large)).toList(),
        ),
      ),
    );
  }
}


