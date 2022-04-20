import 'package:image_picker/image_picker.dart';

class CarModel {
  CarModel({
    required this.id,
    required this.brand,
    required this.price,
    this.url,
    this.file,
  });

  final int id;
  final String brand;
  final double price;
  final String? url;
  final XFile? file;
}
