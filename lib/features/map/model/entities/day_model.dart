import 'package:explore_egypt/features/map/model/entities/activity_model.dart';

class DayModel {
  final int totalCost;
  final List<ActivityModel> activity;

  DayModel({required this.totalCost, required this.activity});

  factory DayModel.fromjson(json) {
    return DayModel(
      totalCost: json['total_cost_usd'] as int,
      activity: (json['activities'] as List)
          .map((e) => ActivityModel.fromjson(e))
          .toList(),
    );
  }
}
