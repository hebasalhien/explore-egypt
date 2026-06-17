import 'package:explore_egypt/features/map/model/entities/day_model.dart';

class TripModel {
  final String? id;
  final int days;
  final String title;
  final bool active;
  final List<DayModel> dayModel;
  TripModel({required this.days, required this.dayModel, required this.title, required this.active,  this.id});

  factory TripModel.fromJson(json) {
    return TripModel(
      id: json['id'] ??'has no id',
      days: json['data']['days'].length,
      title: json['data']['title'],
      active: json['active'] ?? false,
      dayModel: (json['data']['days'] as List)
          .map((e) => DayModel.fromjson(e))
          .toList(),
    );
  }
}
