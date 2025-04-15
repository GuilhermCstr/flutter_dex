import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  String? _selectedPokemonId;
  final PageController pageController = PageController(initialPage: 0);

  int get currentIndex => _currentIndex;
  String? get selectedPokemonId => _selectedPokemonId;

  void goToPage(int index, {String? pokemonId}) {
    _currentIndex = index;
    _selectedPokemonId = pokemonId;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}