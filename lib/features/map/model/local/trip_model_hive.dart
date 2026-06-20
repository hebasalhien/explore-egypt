import 'package:hive/hive.dart';
import 'day_model_hive.dart';

part 'trip_model_hive.g.dart';

@HiveType(typeId: 3)
class TripModelHive extends HiveObject {
  @HiveField(0)
  late String? remoteId;

  @HiveField(1)
  late int days;

  @HiveField(2)
  late String title;

  @HiveField(3)
  late bool active;

  @HiveField(4)
  late List<DayModelHive> dayModels;
}