import 'package:flutter/material.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  bool _isObscured = true;

  bool get isObscured => _isObscured;

  void toggleVisibility() {
    _isObscured = !_isObscured;
    notifyListeners();
  }
}
