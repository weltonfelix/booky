import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookObject {
  const BookObject(
      {required this.title,
      required this.author,
      required this.publisher,
      required this.year,
      required this.coverImageURL,
      required this.bookUrl});

  final String title;
  final String author;
  final String publisher;
  final String year;
  final String coverImageURL;
  final String bookUrl;
}

class BookCard extends StatelessWidget {
  const BookCard({Key? key, required this.bookData}) : super(key: key);

  final BookObject bookData;

  _launchUrl() async {
    final Uri url = Uri.parse(bookData.bookUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${bookData.title}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: theme.colorScheme.surfaceVariant,
        child: InkWell(
          onTap: _launchUrl,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 100,
                        child: AspectRatio(
                            aspectRatio: 0.7,
                            child: Image.network(
                              bookData.coverImageURL,
                              semanticLabel: "Cover",
                              errorBuilder: (_, error, __) {
                                developer.log(
                                  "Failed to load \"${bookData.title}\" cover image: $error",
                                  name: 'BookCard',
                                  error: error,
                                );
                                return Image.asset(
                                  "assets/images/cover_placeholder.png",
                                  fit: BoxFit.cover,
                                  semanticLabel: "Cover",
                                );
                              },
                              fit: BoxFit.cover,
                            )),
                      )),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookData.title,
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              bookData.author,
                              style: theme.textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              bookData.publisher,
                              style: theme.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Text(bookData.year, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
