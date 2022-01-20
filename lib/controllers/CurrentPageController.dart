import 'dart:developer' as developer;
import 'package:flutter/widgets.dart';

class CurrentPageController extends ChangeNotifier {
  int _currentPage = 0;

  CurrentPageController(this._currentPage);
  int get getCurrentPage => _currentPage;

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

}