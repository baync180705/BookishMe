part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

final class BookLoaded extends BookState {
  final List<BookModel> model;

  const BookLoaded({required this.model});
}

final class BookLoading extends BookState {
  final List<BookModel> fetchedBooks;

  BookLoading({required this.fetchedBooks});
}

final class BookError extends BookState {}
