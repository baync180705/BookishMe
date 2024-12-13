import 'package:bookishme/data/models/book_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final String baseUrl = "https://www.googleapis.com/books/v1/volumes";

  Future<List<BookModel>?> fetchBooksByStartIndex(
      int startIndex, String query) async {
    final Dio dio = Dio();

    try {
      final result = await dio.get(
          '$baseUrl?q=$query&filter=ebooks&maxResults=10&startIndex=$startIndex',
          options: Options(headers: {
            "q": query,
            "filter": "ebooks",
            "maxResults": 10,
            "startIndex": startIndex
          }));
      final data = result.data["items"];
      final List<BookModel> bookList = (data as List<dynamic>)
          .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return bookList;
    } catch (e) {
      return null;
    }
  }
}
