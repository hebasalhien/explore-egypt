import 'package:explore_egypt/features/map/model/entities/step_model.dart';

class DayModel {
  final String totalCost;
  final List<PlanStepModel> planStep;

  DayModel({required this.totalCost, required this.planStep});

  factory DayModel.fromjson(json) {
    return DayModel(
      totalCost: json['total_cost'],
      planStep: (json['itinerary'] as List)
          .map((e) => PlanStepModel.fromjson(e))
          .toList(),
    );
  }
}