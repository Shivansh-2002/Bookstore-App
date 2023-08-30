import 'package:flutter/material.dart';
import '../utilities/util.dart';

// This class is used to call all the books from same genre
class BookDetailPage extends StatefulWidget {
  // Define any necessary parameters to pass data to the book detail page
  final String bookId;
  final List<Book> genreBook;
  const BookDetailPage({super.key, required this.bookId, required this.genreBook});
  @override
  // ignore: library_private_types_in_public_api
  _BookDetailPageState createState() => _BookDetailPageState();
}

//Simple enough code for calling a new page containing books from same genre
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildRowsOfBooks(widget.genreBook),
        ),
      ),
    );
  }
}
List<Widget> _buildRowsOfBooks(List<Book> books) {
  List<Widget> rows = [];
  for (int i = 0; i < books.length; i += 2) {
    if (i + 1 < books.length) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BookCard(book:books[i],cardSize: CardSize.large, bookLiked: false,),
          BookCard(book:books[i + 1],cardSize: CardSize.large, bookLiked: false,),
        ],
      ));
    } else {
      rows.add(Row(
        children: [BookCard(book:books[i],cardSize: CardSize.large, bookLiked: false,)],
      ));
    }
  }
  return rows;
}



