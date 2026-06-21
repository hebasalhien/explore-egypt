class ActivePlanModel {
  final String? planName;
  final int? theCurrentDay;
  final int? planDays;
  final String? time;
  final String? title;

  ActivePlanModel({
    this.planName,
    this.theCurrentDay,
    this.planDays,
    this.time,
    this.title,
  });

  bool get isEmpty => planName == null && planDays == null;
  bool get isNotEmpty => !isEmpty;

  factory ActivePlanModel.fromjson(Map<String, dynamic> json) {
    return ActivePlanModel(
      planName: json['title'],
      theCurrentDay: json['currentDay'],
      planDays: json['totalDays'],
      time: json['nextDestination']['time'],
      title: json['nextDestination']['title'].toString(),
    );
  }
}
