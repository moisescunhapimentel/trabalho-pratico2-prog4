import 'package:flutter/foundation.dart';
import 'package:trabalho2/models/breed.dart';

import 'package:trabalho2/models/dog_image.dart';

class Dog {
  DogImage? dogImage;
  List<Breed>? breeds;

  Dog({this.dogImage, this.breeds});

  Dog.fromJson(Map<String, dynamic> json) {
    dogImage = DogImage.fromJson(json);
    if (json['breeds'] != null) {
      breeds = [];
      json['breeds'].forEach((v) {
        breeds!.add(Breed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = dogImage?.id;
    data['width'] = dogImage?.width;
    data['height'] = dogImage?.height;
    data['url'] = dogImage?.url;

    if (breeds != null) {
      data['breeds'] = breeds!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  @override
  bool operator ==(covariant Dog other) {
    if (identical(this, other)) return true;

    return listEquals(other.breeds, breeds);
  }

  @override
  int get hashCode => breeds.hashCode;
}
