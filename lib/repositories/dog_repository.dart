import 'package:dio/dio.dart';
import 'package:trabalho2/models/dog.dart';
import 'package:trabalho2/models/dog_image.dart';

class Repository {
  final String urlBase;

  Repository({
    required this.urlBase,
  });
}

class DogRepository extends Repository {
  final Dio _dio;

  DogRepository({required Dio dio})
      : _dio = dio,
        super(urlBase: 'https://api.thedogapi.com/v1/images');

  Future<List<DogImage>> getRandomImages() async {
    final response = await _dio.get(
      '$urlBase/search',
      queryParameters: {
        'limit': 10,
      },
    );

    final images = response.data as List;
    final dogImages = images
        .map(
          (e) => DogImage.fromJson(e),
        )
        .toList();

    return dogImages;
  }

  Future<Dog?> getDogById({required String id}) async {
    final response = await _dio.get('$urlBase/$id');

    final dogJson = response.data as Map<String, dynamic>;
    return Dog.fromJson(dogJson);
  }
}
