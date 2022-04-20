import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailVM extends ChangeNotifier {
  late final brandController = TextEditingController(text: carBrand);
  late final priceController = TextEditingController(text: carPrice.toString());
  late final imageController = TextEditingController(text: imageUrl);

  bool isUrlSource = false;
  bool enabled = false;

  String? carBrand;
  String? imageUrl;
  double? carPrice;

  late XFile? image;

  bool check() {
    if (brandController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        (image != null || imageController.text.isNotEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  void stateUpdate() {
    notifyListeners();
  }
}
