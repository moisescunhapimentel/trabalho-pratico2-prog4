import 'package:trabalho2/models/weigth.dart';

class Breed {
  Weight? weight;
  int? id;
  String? name;
  String? temperament;
  String? origin;
  String? countryCodes;
  String? countryCode;
  String? lifeSpan;
  String? wikipediaUrl;

  Breed(
      {this.weight,
      this.id,
      this.name,
      this.temperament,
      this.origin,
      this.countryCodes,
      this.countryCode,
      this.lifeSpan,
      this.wikipediaUrl});

  Breed.fromJson(Map<String, dynamic> json) {
    weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    id = json['id'];
    name = json['name'];
    temperament = json['temperament'];
    origin = json['origin'];
    countryCodes = json['country_codes'];
    countryCode = json['country_code'];
    lifeSpan = json['life_span'];
    wikipediaUrl = json['wikipedia_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (weight != null) {
      data['weight'] = weight!.toJson();
    }
    data['id'] = id;
    data['name'] = name;
    data['temperament'] = temperament;
    data['origin'] = origin;
    data['country_codes'] = countryCodes;
    data['country_code'] = countryCode;
    data['life_span'] = lifeSpan;
    data['wikipedia_url'] = wikipediaUrl;
    return data;
  }

  @override
  bool operator ==(covariant Breed other) {
    if (identical(this, other)) return true;

    return other.weight == weight &&
        other.id == id &&
        other.name == name &&
        other.temperament == temperament &&
        other.origin == origin &&
        other.countryCodes == countryCodes &&
        other.countryCode == countryCode &&
        other.lifeSpan == lifeSpan &&
        other.wikipediaUrl == wikipediaUrl;
  }

  @override
  int get hashCode {
    return weight.hashCode ^
        id.hashCode ^
        name.hashCode ^
        temperament.hashCode ^
        origin.hashCode ^
        countryCodes.hashCode ^
        countryCode.hashCode ^
        lifeSpan.hashCode ^
        wikipediaUrl.hashCode;
  }
}
