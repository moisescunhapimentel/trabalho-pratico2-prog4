class DogImage {
  String? id;
  String? url;
  int? width;
  int? height;

  DogImage({this.id, this.url, this.width, this.height});

  DogImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
