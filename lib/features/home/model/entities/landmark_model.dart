class LandmarkModel {
  final String name;
  final String subtitle;
  final String imageUrl;
  final double lat;
  final double lng;
  final String? id;
  final String locationUrl;
  final String category;
  final String price;
  final double rating;
  final int reviewCount;
  final String duration;
  final String description;
  final List<String> imagesUrl;
  final String bestTimeToVisit;
  final bool isFavorite;
  LandmarkModel({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.lat,
    required this.lng,
    this.id,
    this.isFavorite = false,
    required this.locationUrl,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.duration,
    required this.description,
    required this.imagesUrl,
    required this.bestTimeToVisit,
  });
  factory LandmarkModel.fromjson(data) {
    return LandmarkModel(
      name: data['name'],
      subtitle: data['subtitle'],
      imageUrl: data['imageUrl'],
      lat: data['lat'],
      lng: data['lng'],
      id: data['id'],
      locationUrl: data['location'],
      category: data['category'],
      price: data['entryFee'],
      rating: data['rating'],
      reviewCount: data['reviewCount'],
      duration: data['durationHours'],
      description: data['description'],
      imagesUrl: data['gallery'].cast<String>(),
      bestTimeToVisit: data['bestTimeToVisit'],
    );
  }
  LandmarkModel copyWith({bool? isFavorite}) {
    return LandmarkModel(
      name: name,
      subtitle: subtitle,
      imageUrl: imageUrl,
      lat: lat,
      lng: lng,
      id: id,
    //  isFavorite: isFavorite ?? this.isFavorite,
      locationUrl: locationUrl,
      category: category,
      price: price,
      rating: rating,
      reviewCount: reviewCount,
      duration: duration,
      description: description,
      imagesUrl: imagesUrl,
      bestTimeToVisit: bestTimeToVisit,
    );
  }
}
