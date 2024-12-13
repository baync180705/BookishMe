import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/search');
      }
    },
    backgroundColor: Colors.amber,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black54,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: "Search",
      ),
    ],
  );
}