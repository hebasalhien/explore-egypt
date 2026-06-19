
class LandmarkModel {
  final String name;
  final String subtitle;
  final String imageUrl;
  final double lat;
  final double lng;
  final String? id;
  final bool isFavorite;
  LandmarkModel({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.lat,
    required this.lng,
    this.id,
    this.isFavorite = false,
  });
  factory LandmarkModel.fromjson(data) {
    return LandmarkModel(
      name: data['name'],
      subtitle: data['subtitle'],
      imageUrl: data['imageUrl'],
      lat: data['lat'],
      lng: data['lng'],
      id: data['id'],
    );
  }
  LandmarkModel copyWith({  
    bool? isFavorite,
  }) {
    return LandmarkModel(
      name: name,
      subtitle: subtitle,
      imageUrl: imageUrl,
      lat: lat,
      lng: lng,
      id: id,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}