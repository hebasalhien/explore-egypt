import 'package:hive/hive.dart';

part 'activity_model_hive.g.dart';

@HiveType(typeId: 1)
class ActivityModelHive extends HiveObject {
  @HiveField(0)
  late int cost;

  @HiveField(1)
  late String time;

  @HiveField(2)
  late String landmarkName;

  @HiveField(3)
  late String description;

  @HiveField(4)
  late String image;

  @HiveField(5)
  late double lat;

  @HiveField(6)
  late double lng;
}