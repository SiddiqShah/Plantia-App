import 'dart:io';
import 'package:flutter/material.dart';

class RecognitionProvider with ChangeNotifier {
  File? _image;
  bool _isLoading = false;
  String _title = '';
  String _subtitle = '';

  File? get image => _image;
  bool get isLoading => _isLoading;
  String get title => _title;
  String get subtitle => _subtitle;

  void setImage(File? img) {
    _image = img;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setSubtitle(String value) {
    _subtitle = value;
    notifyListeners();
  }

  void clearAll() {
    _image = null;
    _isLoading = false;
    _title = '';
    _subtitle = '';
    notifyListeners();
  }
}