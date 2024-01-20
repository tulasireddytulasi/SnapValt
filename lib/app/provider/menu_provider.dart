import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  int _selectedMenuIndex = 0;

  int get selectedMenuIndex => _selectedMenuIndex;

  int _selectedSubMenuIndex = 0;

  int get selectedSubMenuIndex => _selectedSubMenuIndex;

  set setSelectedMenuIndex(int selectedMenuIndex) {
    _selectedMenuIndex = selectedMenuIndex;
    notifyListeners();
  }

  set setSelectedSubMenuIndex(int selectedSubMenuIndex){
    _selectedSubMenuIndex = selectedSubMenuIndex;
    notifyListeners();
  }
}
