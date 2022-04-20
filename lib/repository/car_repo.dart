import 'package:flutter_hw_17_practic_block_app/models/car_model.dart';

class CarRepo {
  Future<List<CarModel>> getCars() async {
    List<CarModel> allCars = [
      CarModel(
        id: 0,
        brand: 'BMW e30',
        price: 2000,
        url:
            'https://i0.wp.com/yupyi.com/images/listings/2018-07/undefined-1530621265-755-e.jpg',
      ),
      CarModel(
        id: 1,
        brand: 'Subaru Legacy',
        price: 3000,
        url:
            'https://auto-database.com/image/subaru-legacy-3-2000-wallpaper-70612.jpg',
      ),
    ];
    return allCars;
  }
}
