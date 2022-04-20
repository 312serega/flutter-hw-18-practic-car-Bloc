part of '../main_screen.dart';

class _CarItem extends StatelessWidget {
  const _CarItem({Key? key, required this.car}) : super(key: key);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              car: car,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (car.url != null && car.url != '')
            Hero(
              tag: car.url!,
              child: Image.network(
                car.url!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          if (car.file != null && car.file != '')
            Hero(
              tag: car.file!,
              child: Image.file(
                File(car.file!.path),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 15),
          Text(
            car.brand,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${car.price} \$',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
