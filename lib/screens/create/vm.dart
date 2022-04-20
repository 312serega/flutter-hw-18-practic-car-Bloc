import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateVM extends ChangeNotifier {
  final imageController = TextEditingController();
  final brandController = TextEditingController();
  final priceController = TextEditingController();
  bool isUrlSource = false;
  String imageName = '';

  XFile? image;

  bool check() {
    if (brandController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        (image != null || imageController.text.isNotEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  void upDate() {
    notifyListeners();
  }
}
