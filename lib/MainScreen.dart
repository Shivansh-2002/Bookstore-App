import 'package:bookstore/searched.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../util.dart';
import 'dart:convert';

class BookstoreHomePage extends StatefulWidget {
  const BookstoreHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookstoreHomePageState createState() => _BookstoreHomePageState();
}

class _BookstoreHomePageState extends State<BookstoreHomePage> {
  List<Book> books = [];
  List<Book> fictionBooks = [];
  List<Book> dramaBooks = [];
  List<Book> mysteryBooks = [];
  List<Book> thrillerBooks = [];
  List<Book> crimeBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBooks("fiction");
    fetchBooks("drama");
    fetchBooks("mystery");
    fetchBooks("thriller");
    fetchBooks("crime");
  }

  Future<void> fetchBooks(String action) async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=subject:$action'),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        if(action == "fiction")        fictionBooks = jsonData['items'].map<Book>((item) => Book.fromJson(item)).toList();
        if(action == "drama")        dramaBooks = jsonData['items'].map<Book>((item) => Book.fromJson(item)).toList();
        if(action == "mystery")        mysteryBooks = jsonData['items'].map<Book>((item) => Book.fromJson(item)).toList();
        if(action == "thriller")        thrillerBooks = jsonData['items'].map<Book>((item) => Book.fromJson(item)).toList();
        if(action == "crime")        crimeBooks = jsonData['items'].map<Book>((item) => Book.fromJson(item)).toList();
      });
    } else {
      // Handle error
    }
  }
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(child: Text('BookZone')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search books...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.white,
                onPressed: () {
                    if(searchText!=''){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(searchText: searchText),
                        ),
                      );

                    }
                },
                child: const Icon(Icons.search,color:Colors.black87 , ),
              ),
            ],
          ),

            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  GenreName("Fiction", fictionBooks,context),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: fictionBooks.map((xx) => buildBookCard(xx,CardSize.small)).toList(),
                    ),
                  ),
                  GenreName("Drama", dramaBooks, context),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: dramaBooks.map((xx) => buildBookCard(xx,CardSize.small)).toList(),
                    ),
                  ),
                  GenreName("Mystery",mysteryBooks, context),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: mysteryBooks.map((xx) => buildBookCard(xx,CardSize.small)).toList(),
                    ),
                  ),
                  GenreName("Thriller", thrillerBooks, context),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: thrillerBooks.map((xx) => buildBookCard(xx,CardSize.small)).toList(),
                    ),
                  ),
                  GenreName("Crime", crimeBooks, context),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: crimeBooks.map((xx) => buildBookCard(xx,CardSize.small)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}