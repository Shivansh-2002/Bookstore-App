import 'package:flutter/material.dart';
import '../utilities/util.dart'; // Import the Book class

class BookDetailsPage extends StatefulWidget {
  final Book book;

  const BookDetailsPage({required this.book});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.book.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              widget.book.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Author: ${widget.book.author}'),
            Text('Description: ${widget.book.description}'),
            Text('publisher: ${widget.book.publisher} pages'),
            Text('Published Date: ${widget.book.publishedDate}'),
          ],
        ),
      ),
    );
  }
}
