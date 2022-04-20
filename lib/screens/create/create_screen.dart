import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_17_practic_block_app/bloc/car_block.dart';
import 'package:flutter_hw_17_practic_block_app/models/car_model.dart';
import 'package:flutter_hw_17_practic_block_app/screens/create/vm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/default_text_field.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавление авто'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => CreateVM(),
        child: Builder(builder: (context) {
          final vm = context.watch<CreateVM>();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                DefaultTextFiel(
                  controller: vm.brandController,
                  lable: 'Укажите бренд',
                ),
                const SizedBox(height: 10),
                DefaultTextFiel(
                  controller: vm.priceController,
                  lable: 'Укажите цену',
                ),
                const SizedBox(height: 10),
                vm.isUrlSource
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              vm.image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              vm.imageName =
                                  '${vm.image?.name.split('.')[0].substring(0, 12) ?? ''}... .${vm.image?.name.split('.')[1] ?? ''}';
                              vm.upDate();
                            },
                            child: const Text(' Выбрать фото'),
                          ),
                          Text(vm.imageName),
                          if (vm.image != null)
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: Image.file(
                                      File(vm.image!.path),
                                      width: 250,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.blue,
                              ),
                            ),
                        ],
                      )
                    : DefaultTextFiel(
                        controller: vm.imageController,
                        lable: 'Ссылка на изображение',
                      ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Switch(
                        value: vm.isUrlSource,
                        onChanged: (value) {
                          vm.isUrlSource = value;
                          vm.upDate();
                        }),
                    const Text('Загрузить с устройства'),
                  ],
                ),
                const SizedBox(height: 30),
                CreateButton(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CreateVM>();
    return ElevatedButton(
      onPressed: () {
        if (vm.check()) {
          BlocProvider.of<CarBlock>(context).add(
            CarCreateEvent(
              newCar: CarModel(
                id: BlocProvider.of<CarBlock>(context).cars.length + 1,
                brand: vm.brandController.text,
                price: double.tryParse(vm.priceController.text) ?? 0,
                url: vm.imageController.text,
                file: vm.image,
              ),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Заполните все поля'),
            ),
          );
        }
      },
      child: const Text('Создать объявление'),
    );
  }
}
