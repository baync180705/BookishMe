import 'package:bookishme/data/models/book_model.dart';
import 'package:bookishme/presentation/bloc/book_bloc.dart';
import 'package:bookishme/presentation/components/bottom_navigation_bar.dart';
import 'package:bookishme/presentation/components/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    context.read<BookBloc>().add(FetchBooks());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent-200)) {
        context
            .read<BookBloc>()
            .add(FetchBooks());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Discover Books", style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Colors.amber,
        ),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            return _mapStateToWidget(state, _scrollController);
          },
        ),
        bottomNavigationBar: buildBottomNavigationBar(context,0));
  }
}

Widget _mapStateToWidget(BookState state, ScrollController scrollController) {
  if (state is BookLoading) {
    return _buildBooksList(state.fetchedBooks, scrollController);
  } else if (state is BookLoaded) {
    return _buildBooksList(state.model, scrollController);
  } else if (state is BookError) {
    return const Center(child: Text("Failed to load books"));
  } else {
    return const Center(child: Text("No books available"));
  }
}

Widget _buildBooksList(
    List<BookModel> books, ScrollController scrollController) {
  if (books.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }
  return ListView.builder(
    controller: scrollController,
    padding: const EdgeInsets.all(10),
    itemCount: books.length,
    itemBuilder: (context, index) {
      final book = books[index];
      return BookCard(book: book);
    },
  );
}
