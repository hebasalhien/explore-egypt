import 'package:explore_egypt/features/map/model/entities/day_model.dart';
import 'package:hive/hive.dart';
import 'activity_model_hive.dart';

part 'day_model_hive.g.dart';

@HiveType(typeId: 2)
class DayModelHive extends HiveObject {
  @HiveField(0)
  int? totalCost;

  @HiveField(1)
  List<ActivityModelHive>? activities;

  DayModel toActivityModel() {
    return DayModel(
      totalCost: totalCost ?? 0,
      activity: activities?.map((a) => a.toActivityModel()).toList() ?? [],
    );
  }
}