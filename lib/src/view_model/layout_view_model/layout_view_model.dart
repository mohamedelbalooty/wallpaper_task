import 'package:flutter/material.dart';

class LayoutViewModel extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void onPageChanged({required int page}) {
    _currentPage = page;
    notifyListeners();
  }
}
