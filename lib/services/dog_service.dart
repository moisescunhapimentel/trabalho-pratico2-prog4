import 'package:trabalho2/models/dog.dart';
import 'package:trabalho2/repositories/dog_repository.dart';

class DogService {
  final DogRepository repository;

  DogService({required this.repository});

  Future<List<Dog>> getDogs() async {
    final dogImages = await repository.getRandomImages();
    return dogImages.map((e) => Dog(dogImage: e)).toList();
  }

  Future<Dog?> getDogById({required String id}) async {
    return await repository.getDogById(id: id);
  }
}
