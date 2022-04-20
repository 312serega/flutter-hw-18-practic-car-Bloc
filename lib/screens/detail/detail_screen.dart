import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_17_practic_block_app/bloc/car_block.dart';
import 'package:flutter_hw_17_practic_block_app/models/car_model.dart';
import 'package:flutter_hw_17_practic_block_app/widgets/default_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'detail_vm.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.car}) : super(key: key);
  final CarModel car;
  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.brand),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => DetailVM(),
          child: Builder(builder: (context) {
            final vm = context.watch<DetailVM>();
            vm.carBrand = car.brand;
            vm.carPrice = car.price;
            vm.imageUrl = car.url;
            vm.image = car.file;

            return Column(
              children: [
                if (vm.imageUrl != null && vm.imageUrl != '')
                  Hero(
                    tag: vm.imageUrl!,
                    child: Image.network(
                      car.url!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (vm.image != null && vm.image != '')
                  Hero(
                    tag: vm.image!,
                    child: Image.file(
                      File(car.file!.path),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      DefaultTextFiel(
                        controller: vm.brandController,
                        lable: 'Бренд',
                        enabled: vm.enabled,
                      ),
                      const SizedBox(height: 15),
                      DefaultTextFiel(
                        controller: vm.priceController,
                        lable: 'Цена',
                        enabled: vm.enabled,
                      ),
                      const SizedBox(height: 15),
                      vm.image != null
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  vm.image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  vm.stateUpdate();
                                },
                                child: const Text('Изменить фото'),
                              ),
                            )
                          : DefaultTextFiel(
                              controller: vm.imageController,
                              lable: 'Фото',
                              enabled: vm.enabled,
                            ),
                      const SizedBox(height: 25),
                      BlocConsumer<CarBlock, CarState>(
                          listener: (context, state) {
                        if (state is CarLoadedState) {
                          Navigator.pop(context);
                        }
                      }, builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: Visibility(
                                visible: !vm.enabled,
                                child: ElevatedButton(
                                  onPressed: state is CarLoadingState
                                      ? null
                                      : () {
                                          vm.enabled = true;
                                          vm.stateUpdate();
                                        },
                                  child: state is CarLoadingState
                                      ? CircularProgressIndicator.adaptive(
                                          backgroundColor: Colors.blue[500],
                                        )
                                      : const Text('Редактировать'),
                                ),
                                replacement: ElevatedButton(
                                  onPressed: () {
                                    if (vm.check()) {
                                      vm.enabled = false;
                                      BlocProvider.of<CarBlock>(context).add(
                                        CarEditEvent(
                                          editedCar: CarModel(
                                              id: car.id,
                                              brand: vm.brandController.text,
                                              price: double.parse(
                                                  vm.priceController.text),
                                              url: vm.imageController.text),
                                        ),
                                      );
                                      vm.stateUpdate();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Заполните все поля'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Применить'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: state is CarDeleteState
                                    ? null
                                    : () {
                                        BlocProvider.of<CarBlock>(context).add(
                                          CarDeleteEvent(id: car.id),
                                        );
                                      },
                                child: state is CarDeleteState
                                    ? CircularProgressIndicator.adaptive(
                                        backgroundColor: Colors.blue[500],
                                      )
                                    : const Text('Удалить'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
