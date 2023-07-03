import 'package:flutter/material.dart';
import '../genre.dart';

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
          : 'http://blog.aspneter.com/Images/no-thumb.jpg',
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
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailPage(bookId: genre, genreBook: genreBook,),
            ),
          );},
        icon: const Icon(Icons.arrow_forward),
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
    padding: const EdgeInsets.all(8),
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
          const SizedBox(height: 8),
          Text(
            book.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

