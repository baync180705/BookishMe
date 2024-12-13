import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookishme/data/models/book_model.dart';
import 'package:bookishme/data/services/api_services.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  int onFetchCount = -1;
  int onSearchCount = -1;
  final List<BookModel> _books = [];
  final ApiServices _bookServices = ApiServices();
  BookBloc() : super(BookLoaded(model: List.empty())) {
    on<FetchBooks>(_onFetch);
    on<SearchBooks>(_onSearch);
  }

  FutureOr<void> _onFetch(FetchBooks event, Emitter<BookState> emit) async {
    print(event.query);
    print("in _onFetch");
    onFetchCount++;
    int startIndex = onFetchCount * 10;
    try {
      emit(BookLoading(fetchedBooks: _books));
      print("Book Loading");
      final result =
          await _bookServices.fetchBooksByStartIndex(startIndex, event.query) ??
              List.empty();
      _books.addAll(result);
      print("prepared books");
      print(_books);
      emit(BookLoaded(model: _books));
    } catch (error) {
      emit(BookError());
    }
  }

  FutureOr<void> _onSearch(SearchBooks event, Emitter<BookState> emit) async {
    print(event.query);
    print("in _onFetch");
    try {
      emit(BookLoading(fetchedBooks: _books));
      print("Book Loading");
      final result =
          await _bookServices.fetchBooksByStartIndex(0, event.query) ??
              List.empty();
      emit(BookLoaded(model: result));
    } catch (error) {
      emit(BookError());
    }
  }
}
