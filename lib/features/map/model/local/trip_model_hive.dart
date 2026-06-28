import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:hive/hive.dart';
import 'day_model_hive.dart';

part 'trip_model_hive.g.dart';
@HiveType(typeId: 3)
class TripModelHive extends HiveObject {
  @HiveField(0)
  String? remoteId;

  @HiveField(1)
  int? days;

  @HiveField(2)
  String? title;

  @HiveField(3)
  bool? active;

  @HiveField(4)
  List<DayModelHive>? dayModels;

  TripModel toTripModel() {
    return TripModel(
      id: remoteId,
      days: days ?? 0,
      title: title ?? '',
      active: active ?? false,
      dayModel: dayModels?.map((day) => day.toActivityModel()).toList() ?? [],
    );
  }
}