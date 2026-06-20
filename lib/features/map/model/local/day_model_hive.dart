import 'package:hive/hive.dart';
import 'activity_model_hive.dart';

part 'day_model_hive.g.dart';

@HiveType(typeId: 2)
class DayModelHive extends HiveObject {
  @HiveField(0)
  late int totalCost;

  @HiveField(1)
  late List<ActivityModelHive> activities;
}