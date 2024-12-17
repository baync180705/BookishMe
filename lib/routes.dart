import 'package:bookishme/presentation/pages/home/home_screen.dart';
import 'package:bookishme/presentation/pages/search/book_search_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomeScreenView(),
  '/search': (context) => const BookSearchPage(),
};
