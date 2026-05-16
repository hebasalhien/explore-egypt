class PlanCardModel {
  final String name;
  final String subtitle;
  final String imageUrl;
  final String id;

  PlanCardModel({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.id,
  });

  factory PlanCardModel.fromJson(json) {
    return PlanCardModel(
      name: json['name'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      id: json['id'],
    );
  }
}
