import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(BookstoreApp());
}

class ScreenUtil {
  static double? screenWidth;
  static double? screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}


class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;

  Book(
      {required this.id,
        required this.title,
        required this.author,
        required this.imageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['volumeInfo']['title'],
      author: json['volumeInfo']['authors'] != null
          ? json['volumeInfo']['authors'][0]
          : 'Unknown',
      imageUrl: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : 'http://via.placeholder.com/640x360',
    );
  }
}

// ignore: non_constant_identifier_names
Widget GenreName(String genre, List<Book> genreBook){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "  $genre Books",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_forward),
      )
    ],
  );
}

Widget buildBookCard(Book book) {
  return Container(
    width: 200,
    height: 300,
    padding: EdgeInsets.all(8),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              book.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            book.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            book.author,
            style: TextStyle(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}


class BookDetailPage extends StatefulWidget {
  // Define any necessary parameters to pass data to the book detail page
  final String bookId;
  BookDetailPage({required this.bookId});
  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for the book detail page
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: Center(
        child: Text('Book ID: ${widget.bookId}'),
      ),
    );
  }
}

class BookstoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookstore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookstoreHomePage(),
    );
  }
}

class BookstoreHomePage extends StatefulWidget {
  @override
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
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=subject:$action)'),
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
      print('Failed to fetch books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookstore'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GenreName("fiction", fictionBooks),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: fictionBooks.map((xx) => buildBookCard(xx)).toList(),
              ),
            ),
            GenreName("drama", dramaBooks),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: dramaBooks.map((xx) => buildBookCard(xx)).toList(),
              ),
            ),
            GenreName("mystery",mysteryBooks),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: mysteryBooks.map((xx) => buildBookCard(xx)).toList(),
              ),
            ),
            GenreName("thriller", thrillerBooks),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: thrillerBooks.map((xx) => buildBookCard(xx)).toList(),
              ),
            ),
            GenreName("crime", crimeBooks),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: crimeBooks.map((xx) => buildBookCard(xx)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
