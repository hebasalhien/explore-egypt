class LandmarkModelPlan {
  final String id;
  final String title;
  final String category;
  // final double lat;
  // final double lng;
  final String imageUrl;
  final String priceEgp;

  LandmarkModelPlan({
    required this.id,
    required this.title,
    required this.category,
    // required this.lat,
    // required this.lng,
    required this.imageUrl,
    required this.priceEgp,
  });

  factory LandmarkModelPlan.fromJson(Map<String, dynamic> json) {
    return LandmarkModelPlan(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      // lat: json['lat'] ?? 0,
      // lng: json['lng'] ?? 0,
      imageUrl: json['imageUrl'],
      priceEgp: json['price'],
    );
  }
}
