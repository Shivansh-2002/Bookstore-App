import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../util.dart';
import 'dart:convert';

// This page will give the searched result for the books from the api
class SearchPage extends StatefulWidget {
  final String searchText;
  @override
  // ignore: use_key_in_widget_constructors
  const SearchPage({required this.searchText});
  // ignore: library_private_types_in_public_api, annotate_overrides
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
        if(jsonData['items']!= null)        searchBooks = jsonData['items'].map<Book>((item) => Book.fromJson(item)).toList();
      });

    } else {
      // Handle error
    }
  }
  @override
  Widget build(BuildContext context) {

    // Implement the UI for the book detail page
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Search Result for ${widget.searchText} '),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: (searchBooks==[])?Center(child: Image.network('https://cdn.dribbble.com/userupload/2905384/file/original-93c7c3593e7d733ddd8ca2fd83ac0ed4.png?compress=1&resize=752x')):
        Column(
          children: searchBooks.map((xx) => buildBookCard(xx, CardSize.large)).toList(),
        ),
      ),
    );
  }
}