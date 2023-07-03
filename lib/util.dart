import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../MainScreen.dart';
import 'dart:convert';

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
          : 'https://via.placeholder.com/640x360',
    );
  }
}

// ignore: non_constant_identifier_names
Widget GenreName(String genre, List<Book> genreBook, BuildContext context){
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailPage(bookId: "$genre", genreBook: genreBook,),
            ),
          );},
        icon: Icon(Icons.arrow_forward),
      )
    ],
  );
}
enum CardSize { small, large }
Widget buildBookCard(Book book, CardSize cardSize) {
  double cardWidth = cardSize == CardSize.small ? 200 : 400;
  double cardHeight = cardSize == CardSize.small ? 300 : 600;
  return Container(
    width: cardWidth,
    height: cardHeight,
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

