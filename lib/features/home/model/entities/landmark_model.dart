class LandmarkModel {
  final String title;
  final String subtitle;
  final String image;

  LandmarkModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
  factory LandmarkModel.fromjson(data) {
    return LandmarkModel(
      title: data['title'],
      subtitle: data['subtitle'],
      image: data['image'],
    );
  }
}
