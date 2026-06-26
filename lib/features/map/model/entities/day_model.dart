import 'package:explore_egypt/features/map/model/entities/activity_model.dart';

class DayModel {
  final int totalCost;
  final List<ActivityModel> activity;

  DayModel({required this.totalCost, required this.activity});

  factory DayModel.fromjson(json) {
    return DayModel(
      totalCost: (json['total_cost_usd'] as num).toInt(),
      activity: (json['activities'] as List)
          .map((e) => ActivityModel.fromjson(e))
          .toList(),
    );
  }

   Map<String, dynamic> toJson() {
    return {
      "total_cost_usd": totalCost,
      "activities": activity.map((e) => e.toJson()).toList(),
    };
  }
}
   
                                          
    