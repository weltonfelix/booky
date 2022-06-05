import 'package:booky/widgets/BookCard.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  const BookList({Key? key, required this.booksData}) : super(key: key);

  final List<BookObject> booksData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 4),
      itemCount: booksData.length,
      itemBuilder: (BuildContext context, int index) {
        final padding = index != 0
            ? const EdgeInsets.only(top: 8)
            : const EdgeInsets.only();
        return Padding(
          padding: padding,
          child: BookCard(bookData: booksData[index]),
        );
      },
    );
  }
}
