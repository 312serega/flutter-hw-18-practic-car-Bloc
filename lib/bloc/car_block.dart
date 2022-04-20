import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/car_model.dart';
import '../repository/car_repo.dart';

class CarBlock extends Bloc<CarEvent, CarState> {
  CarBlock({required this.repo}) : super(CarInitialState()) {
    on<CarLoadEvent>(
      (event, emit) async {
        emit(CarLoadingState());
        await Future.delayed(const Duration(seconds: 2));

        cars = await repo.getCars();

        emit(CarLoadedState(cars: cars));
      },
    );

    on<CarCreateEvent>(
      (event, emit) async {
        emit(CarLoadingState());
        await Future.delayed(const Duration(seconds: 2));
        cars.add(event.newCar);
        emit(CarLoadedState(cars: cars));
      },
    );

    on<CarEditEvent>(
      (event, emit) async {
        emit(CarLoadingState());
        await Future.delayed(const Duration(seconds: 2));
        List<CarModel> newList = [];

        for (var car in cars) {
          if (car.id == event.editedCar.id) {
            newList.add(event.editedCar);
          } else {
            newList.add(car);
          }
        }
        cars = newList;
        emit(CarLoadedState(cars: cars));
      },
    );

    on<CarDeleteEvent>(
      (event, emit) async {
        emit(CarDeleteState());
        await Future.delayed(const Duration(seconds: 2));
        List<CarModel> newList = [];

        for (var car in cars) {
          if (car.id != event.id) {
            newList.add(car);
          }
        }
        cars = newList;
        emit(CarLoadedState(cars: cars));
      },
    );
  }

  final CarRepo repo;
  List<CarModel> cars = [];
}

@immutable
abstract class CarEvent {}

class CarLoadEvent extends CarEvent {}

class CarCreateEvent extends CarEvent {
  final CarModel newCar;

  CarCreateEvent({required this.newCar});
}

class CarEditEvent extends CarEvent {
  final CarModel editedCar;

  CarEditEvent({required this.editedCar});
}

class CarDeleteEvent extends CarEvent {
  final int id;

  CarDeleteEvent({required this.id});
}

@immutable
abstract class CarState {}

class CarInitialState extends CarState {}

class CarLoadingState extends CarState {}

class CarDeleteState extends CarState {}

class CarLoadedState extends CarState {
  final List<CarModel> cars;

  CarLoadedState({required this.cars});
}
