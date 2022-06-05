class Book {
  final String title;
  final String author;
  final String publisher;
  final String year;
  final String coverImageUrl;
  final String bookUrl;

  const Book({
    required this.title,
    required this.author,
    required this.publisher,
    required this.year,
    required this.coverImageUrl,
    required this.bookUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    String getYearFromDataString(String dateString) {
      return dateString.split('-')[0];
    }

    return Book(
      title: json['volumeInfo']?['title'] ?? "",
      author: json['volumeInfo']?['authors']?.join(', ') ?? "",
      publisher: json['volumeInfo']?['publisher'] ?? "",
      year: getYearFromDataString(json['volumeInfo']?['publishedDate'] ?? ""),
      coverImageUrl: json['volumeInfo']?['imageLinks']?['smallThumbnail'] ?? "",
      bookUrl: json['volumeInfo']?['infoLink'] ?? "",
    );
  }

  static List<Book> fromJsonVolumesResponse(Map<String, dynamic> json) {
    final results = json['items'];
    if (results == null) return [];

    List<Book> books = [];

    for (var jsonBook in results) {
      final book = Book.fromJson(jsonBook);
      books.add(book);
    }

    return books;
  }
}
