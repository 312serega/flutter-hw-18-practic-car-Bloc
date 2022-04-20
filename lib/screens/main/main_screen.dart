import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_17_practic_block_app/bloc/car_block.dart';
import 'package:flutter_hw_17_practic_block_app/models/car_model.dart';
import 'package:flutter_hw_17_practic_block_app/screens/create/create_screen.dart';
import 'package:flutter_hw_17_practic_block_app/screens/detail/detail_screen.dart';
part 'widgets/car_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CarBlock, CarState>(
        builder: (context, state) {
          if (state is CarLoadedState) {
            return ListView.separated(
              padding: const EdgeInsets.all(14),
              itemBuilder: (context, index) => _CarItem(
                car: state.cars[index],
              ),
              itemCount: state.cars.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            );
          }
          if (state is CarLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
