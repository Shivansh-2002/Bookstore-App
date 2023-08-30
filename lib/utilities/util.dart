import 'package:flutter/material.dart';
import '../auth/signup.dart';
import '../screens/genre.dart';
import '../screens/book_details_page.dart';

// this the utilities files which contain different classes which are needed on different pages

// Book class will contain the important information about a book
class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final String publisher;
  final String description;
  final String publishedDate;

  Book(
      {required this.id,
        required this.title,
        required this.author,
        required this.publisher,
        required this.imageUrl,
        required this.description,
        required this.publishedDate,
      });
  /*The class also includes a factory method fromJson that takes a JSON map as input and creates a Book object.
  This factory method is responsible for extracting the relevant data from the JSON map and initializing the
  corresponding properties of the Book object.*/
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
      description: json['volumeInfo']['description'] != null?json['volumeInfo']['description']:'No description available',
      publisher: json['volumeInfo']['publisher']!= null?json['volumeInfo']['publisher']:"Unknown",
      publishedDate: json['volumeInfo']['publishedDate']!= null?json['volumeInfo']['publishedDate']: 'Unknown',

    );
  }
}


/* I have created this widget to show the different genre's names and added a
 button which will direct us to a new page which will have books from the selected genre */
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
          // Pushing the above discussed page
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

// This Widget helps to make the Book Card using only this widget i am creating
// all the cards on all the pages
enum CardSize { small, large }
class BookCard extends StatefulWidget {
  final Book book;
  final CardSize cardSize;
  final bool bookLiked;
  const BookCard({required this.book, required this.cardSize, required this.bookLiked});

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool bookLiked = false;

  @override
  Widget build(BuildContext context) {
    double cardWidth = widget.cardSize == CardSize.small ? 200 : 180;
    double cardHeight = widget.cardSize == CardSize.small ? 300 : 270;

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsPage(book: widget.book),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 2),
                    child: Image.network(
                      widget.book.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    widget.book.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    widget.book.author,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    bookLiked ? Icons.favorite : Icons.favorite_border,
                    color: bookLiked ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      bookLiked = !bookLiked;
                      // Add your logic for liking/unliking a book here
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


hexStringToColor(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if(hexColor.length == 6){
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
