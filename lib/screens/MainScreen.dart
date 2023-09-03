import 'package:firebase_auth/firebase_auth.dart';
import '../auth/signin.dart';
import '../screens/searched.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../utilities/util.dart';
import '../utilities/api_call_state.dart';
import 'dart:convert';

class BookstoreHomePage extends StatefulWidget {
  const BookstoreHomePage({Key? key}) : super(key: key);

  @override
  _BookstoreHomePageState createState() => _BookstoreHomePageState();
}

class _BookstoreHomePageState extends State<BookstoreHomePage> {
  bool isLoading = true;
  List<Book> fictionBooks = [];
  List<Book> dramaBooks = [];
  List<Book> mysteryBooks = [];
  List<Book> thrillerBooks = [];
  List<Book> crimeBooks = [];
  String searchText = '';

  void logoutAndNavigateToLoginScreen() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      await fetchBooks("fiction");
      await fetchBooks("drama");
      await fetchBooks("mystery");
      await fetchBooks("thriller");
      await fetchBooks("crime");
    } catch (error) {
      // Handle errors
    }
  }

  Future<void> fetchBooks(String action) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=subject:$action',
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Book> fetchedBooks = jsonData['items']
            .map<Book>((item) => Book.fromJson(item))
            .toList();

        setState(() {
          if (action == "fiction")
            fictionBooks = fetchedBooks;
          if (action == "drama")
            dramaBooks = fetchedBooks;
          if (action == "mystery")
            mysteryBooks = fetchedBooks;
          if (action == "thriller")
            thrillerBooks = fetchedBooks;
          if (action == "crime") crimeBooks = fetchedBooks;
        });
      } else {
        // Handle error
      }
      await Future.delayed(Duration(milliseconds: 300));
    } catch (error) {
      // Handle any errors that might occur during the API call
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(child: Text('BookWander')),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () {
              logoutAndNavigateToLoginScreen();
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(searchText: value),
                              ),
                            );
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search books...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2.0),
                  FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      if (searchText != '') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchPage(searchText: searchText),
                          ),
                        );
                      }
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    GenreName("Fiction", fictionBooks, context),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: fictionBooks
                            .map((xx) =>
                            BookCard(book: xx, cardSize: CardSize.small, bookLiked: false,))
                            .toList(),
                      ),
                    ),
                    GenreName("Drama", dramaBooks, context),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dramaBooks
                            .map((xx) =>
                            BookCard(book: xx, cardSize: CardSize.small, bookLiked: false,))
                            .toList(),
                      ),
                    ),
                    GenreName("Mystery", mysteryBooks, context),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: mysteryBooks
                            .map((xx) =>
                            BookCard(book: xx, cardSize: CardSize.small, bookLiked: false,))
                            .toList(),
                      ),
                    ),
                    GenreName("Thriller", thrillerBooks, context),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: thrillerBooks
                            .map((xx) =>
                            BookCard(book: xx, cardSize: CardSize.small, bookLiked: false,))
                            .toList(),
                      ),
                    ),
                    GenreName("Crime", crimeBooks, context),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: crimeBooks
                            .map((xx) =>
                            BookCard(book: xx, cardSize: CardSize.small, bookLiked: false,))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
