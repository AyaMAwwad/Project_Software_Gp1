import 'package:flutter/material.dart';

class Providercurrency extends ChangeNotifier {
  static String _selectedCurrency = 'ILS';

  static String get selectedCurrency => _selectedCurrency;

  void setCurrency(String currencyCode) {
    _selectedCurrency = currencyCode;

    print('result currency $_selectedCurrency \n \n ');

    notifyListeners();
  }
}
