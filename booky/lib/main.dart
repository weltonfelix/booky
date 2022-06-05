import 'package:booky/services/googleBooksApi.dart';
import 'package:booky/theme/colors.dart';
import 'package:booky/theme/themes.dart';
import 'package:booky/widgets/BookCard.dart';
import 'package:booky/widgets/BookList.dart';
import 'package:booky/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booky',
      theme: AppThemes.lightTheme(context),
      darkTheme: AppThemes.darkTheme(context),
      // darkTheme: AppThemes.darkTheme,
      home: Builder(
        builder: (context) => const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _books = <BookObject>[];
  var _searchQuery = '';
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: theme.colorScheme.background,
      statusBarColor: AppColors.blue500,
    ));

    handleSearch(String query) async {
      if (query.isEmpty) {
        setState(() {
          _books = <BookObject>[];
        });
        return;
      }
      setState(() {
        _isLoading = true;
      });

      try {
        final results = await GoogleBooksApi.getBooks(query);

        final newBooks = results.map((element) {
          return BookObject(
              title: element.title,
              author: element.author,
              publisher: element.publisher,
              year: element.year,
              coverImageURL: element.coverImageUrl,
              bookUrl: element.bookUrl);
        }).toList();

        setState(() {
          _books = newBooks;
          _isLoading = false;
        });
      } on Exception {
        setState(() {
          _isLoading = false;
        });
        final snackBar = SnackBar(
          content: Text("Error searching for books",
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.background)),
          backgroundColor: theme.colorScheme.onSurface,
          action: SnackBarAction(
            label: 'Retry',
            textColor: theme.colorScheme.primary,
            onPressed: () {
              handleSearch(_searchQuery);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(toolbarHeight: 64, title: const Text('Booky')),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 32, right: 16, left: 16),
          child: Column(
            children: [
              SearchBar(
                  label: "Search for your favorite books",
                  onSearchChange: (value) {
                    setState(() => {_searchQuery = value});
                    handleSearch(value);
                  }),
              const SizedBox(height: 32),
              Expanded(child: () {
                if (_isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_searchQuery.isEmpty) {
                  return Text('Type a book name to search',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700));
                } else if (_books.isEmpty) {
                  return Text('No books found',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700));
                }
                return BookList(
                  booksData: _books,
                );
              }()),
            ],
          ),
        ),
      ),
    );
  }
}
