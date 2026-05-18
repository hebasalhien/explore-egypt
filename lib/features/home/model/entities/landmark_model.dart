class LandmarkModel {
  final String name;
  final String subtitle;
  final String imageUrl;
  final double lat;
  final double lng;

  LandmarkModel({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.lat,
    required this.lng
  });
  factory LandmarkModel.fromjson(data) {
    return LandmarkModel(
      name: data['name'],
      subtitle: data['subtitle'],
      imageUrl: data['imageUrl'],
      lat: data['lat'],
      lng: data['lng'],
    );
  }
}
