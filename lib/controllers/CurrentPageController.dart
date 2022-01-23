import 'dart:developer' as developer;
import 'package:flutter/widgets.dart';

class CurrentPageController extends ChangeNotifier {
  String _name;
  int _currentPage = 0;

  CurrentPageController(this._currentPage, this._name);
  int get getCurrentPage => _currentPage;
  String get name => _name;

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void setNamePage(String name) {
    _name = name;
    notifyListeners();
  }

}