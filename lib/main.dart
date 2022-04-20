import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_17_practic_block_app/bloc/car_block.dart';
import 'package:flutter_hw_17_practic_block_app/repository/car_repo.dart';

import 'screens/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CarRepo(),
      child: BlocProvider(
        create: (context) => CarBlock(
          repo: RepositoryProvider.of<CarRepo>(context),
        )..add(
            CarLoadEvent(),
          ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
