import 'package:flutter/material.dart';
import '../util.dart';


class BookDetailPage extends StatefulWidget {
  // Define any necessary parameters to pass data to the book detail page
  final String bookId;
  final List<Book> genreBook;
  const BookDetailPage({super.key, required this.bookId, required this.genreBook});
  @override
  // ignore: library_private_types_in_public_api
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for the book detail page
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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


