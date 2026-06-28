import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:hive/hive.dart';

part 'activity_model_hive.g.dart';

@HiveType(typeId: 1)
class ActivityModelHive extends HiveObject {
  @HiveField(0)
  int? cost;

  @HiveField(1)
  String? time;

  @HiveField(2)
  String? landmarkName;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? image;

  @HiveField(5)
  double? lat;

  @HiveField(6)
  double? lng;

  @HiveField(7)
  String? id;

  ActivityModel toActivityModel() {
    return ActivityModel(
      cost: cost ?? 0,
      time: time ?? '',
      landmarkName: landmarkName ?? '',
      description: description ?? '',
      image: image ,
      lat: lat ?? 0.0,
      lng: lng ?? 0.0,
      id: id ?? '',
    );
  }
}