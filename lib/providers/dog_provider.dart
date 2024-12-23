import 'package:flutter/material.dart';
import 'package:trabalho2/models/dog.dart';
import 'package:trabalho2/services/dog_service.dart';
import 'package:trabalho2/utils/custom_response.dart';

class DogProvider with ChangeNotifier {
  final List<Dog> _dogs = [];
  final DogService _dogService;
  Dog? _currentDog;

  DogProvider({required DogService dogService}) : _dogService = dogService;

  List<Dog> get dogs => _dogs;

  Dog? get currentDog => _currentDog;

  void selectDog({required int index}) {
    _currentDog = _dogs[index];
    notifyListeners();
  }

  Future<CustomResponse<bool>> loadMoreDogsIfEmpty() async {
    if (_dogs.isEmpty) {
      return await loadDogs();
    }

    return CustomResponse(value: false);
  }

  Future<CustomResponse<bool>> loadDogs() async {
    try {
      final dogs = await _dogService.getDogs();
      _dogs.addAll(dogs);
      notifyListeners();
      return CustomResponse(value: true);
    } catch (e) {
      return CustomResponse(
          value: false, error: 'Não foi possível carregar os pets');
    }
  }

  Future<CustomResponse<bool>> loadBreedsInCurrentDogIfNotExists() async {
    if (currentDog?.breeds != null) {
      return CustomResponse(value: true);
    } else if (currentDog?.dogImage?.id == null) {
      return CustomResponse(
          value: false, error: 'Não foi possível carregar as informações');
    }

    final index = _dogs.indexWhere(
      (element) => element.dogImage?.id == currentDog?.dogImage?.id,
    );

    if (index == -1) {
      return CustomResponse(
          value: false,
          error: 'O pet selecionado não foi identificado pelo sistema');
    }

    final dogWithBreeds =
        await _dogService.getDogById(id: currentDog!.dogImage!.id!);

    dogWithBreeds?.breeds ??= [];

    _dogs[index] = dogWithBreeds ?? _dogs[index];

    _currentDog = _dogs[index];

    notifyListeners();

    return CustomResponse(value: true);
  }

  Future<CustomResponse<bool>> loadMoreDogsIfLimitReached(int limit) async {
    if (limit == _dogs.length - 1) {
      return await loadDogs();
    }

    return CustomResponse(value: false);
  }
}
