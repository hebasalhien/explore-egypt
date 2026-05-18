import 'package:explore_egypt/features/map/model/entities/day_model.dart';

class TripModel {
  final int days;
  final String title;
  final List<DayModel> dayModel;
  TripModel({required this.days, required this.dayModel, required this.title});

  factory TripModel.fromJson(json) {
    return TripModel(
      days: json['data']['days'].length,
      title: json['data']['title'],
      dayModel: (json['data']['days'] as List)
          .map((e) => DayModel.fromjson(e))
          .toList(),
    );
  }
}
