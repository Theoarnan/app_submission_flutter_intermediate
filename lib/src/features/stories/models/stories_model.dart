class StoriesModel {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final num? lat;
  final num? lon;

  StoriesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory StoriesModel.fromMap(Map<String, dynamic> map) {
    return StoriesModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      createdAt: map['createdAt'] ?? '',
      lat: map['lat'],
      lon: map['lon'],
    );
  }
}
