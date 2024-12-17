import 'package:bookishme/data/models/book_model.dart';
import 'package:bookishme/presentation/components/bottom_navigation_bar.dart';
import 'package:bookishme/presentation/components/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookishme/presentation/bloc/book_bloc.dart';

class BookSearchPage extends StatelessWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Books", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _SearchBar(),
            const SizedBox(height: 10),
            Expanded(child: _SearchResults()),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 1),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      String query = _controller.text.toLowerCase().replaceAll(" ", "-");
      context.read<BookBloc>().add(SearchBooks(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: "Search for books...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BookLoaded) {
          return _buildBooksList(state.model);
        } else if (state is BookError) {
          return const Center(child: Text("Failed to load books"));
        } else {
          return const Center(child: Text("Start typing to search for books"));
        }
      },
    );
  }

  Widget _buildBooksList(List<BookModel> books) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(book: book);
      },
    );
  }
}
