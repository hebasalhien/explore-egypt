class PlanCardModel {
  final String name;
  final String subtitle;
  final String imageUrl;
  final String id;
  final bool isFavorite;

  PlanCardModel({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.id,
    this.isFavorite = false,
  });

  factory PlanCardModel.fromJson(Map<String, dynamic> json) {
    return PlanCardModel(
      name: json['name'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      id: json['id'],
    );
  }

  PlanCardModel copyWith({bool?
   isFavorite}) 
   {
    return PlanCardModel(
      name: name,
      subtitle: subtitle,
      imageUrl: imageUrl,
      id: id,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
