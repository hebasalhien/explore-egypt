class PlanStepModel {
  final String cost;
  final String time;
  final String landmarkName;
  final String description;
  final String image;

  PlanStepModel({
    required this.cost,
    required this.time,
    required this.landmarkName,
    required this.description,
    required this.image,
  });

  factory PlanStepModel.fromjson(json) {
    return PlanStepModel(
      cost: json['cost'],
      time: json['time'],
      landmarkName: json['title'],
      description: json['description'],
      image: json['image_url'],
    );
  }
}
