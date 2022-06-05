import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'models/Books.dart';

class GoogleBooksApi {
  static Future<List<Book>> getBooks(String query) async {
    if (query.isEmpty) return [];
    final path = Uri.parse("${dotenv.env['GOOGLE_BOOKS_API_URL']!}/volumes")
        .replace(queryParameters: {
      "q": query,
      "key": dotenv.env['GOOGLE_BOOKS_API_KEY']!
    });

    try {
      final response = await http.get(path);

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        return Book.fromJsonVolumesResponse(jsonBody);
      } else {
        throw Exception('Failed to load books: ${response.body}');
      }
    } on Exception catch (exception, stackTrace) {
      developer.log(
        "Failed to load books: $exception",
        name: 'GoogleBooksApi',
        error: exception,
      );
      rethrow;
    }
  }
}
