import 'package:flutter/material.dart';

class ApiCallState extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Function to set the isLoading flag and notify listeners
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners(); // This is important to notify listeners when the state changes.
  }
}
