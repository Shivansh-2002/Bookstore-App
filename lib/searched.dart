import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../util.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  final String searchText;
  @override
  // ignore: use_key_in_widget_constructors
  const SearchPage({required this.searchText});
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<Book> searchBooks = [];
  @override
  void initState() {
    super.initState();
    fetchSearchBooks();
  }

  Future<void> fetchSearchBooks() async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=${widget.searchText}'),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        searchBooks = jsonData['items'].map<Book>((item) => Book.fromJson(item)).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch books');
    }
  }
  @override
  Widget build(BuildContext context) {

    // Implement the UI for the book detail page
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result for ${widget.searchText} '),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: searchBooks.map((xx) => buildBookCard(xx, CardSize.large)).toList(),
        ),
      ),
    );
  }
}