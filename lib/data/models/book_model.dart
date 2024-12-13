class BookModel {
  final String? title;
  final String? author;
  final String? coverPath;
  final String? publishedDate;
  final String? language;
  final int? pageCount;
  final String? description;
  final String? selfLink;

  BookModel(
      {required this.author,
      required this.title,
      required this.coverPath,
      required this.publishedDate,
      required this.language,
      required this.pageCount,
      required this.description,
      required this.selfLink});

  factory BookModel.fromJson(Map<String, dynamic> jsonData) {
    final Map info = jsonData["volumeInfo"];
    return BookModel(
        author: info["authors"]?[0] ?? "unavailable",
        title: info["title"],
        coverPath: info["imageLinks"]["thumbnail"],
        publishedDate: info["publishedDate"],
        description: info["description"],
        pageCount: info["pageCount"],
        language: info["language"],
        selfLink: jsonData["selfLink"]);
        
  }
}
