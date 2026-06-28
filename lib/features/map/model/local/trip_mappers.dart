import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:explore_egypt/features/map/model/entities/day_model.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'activity_model_hive.dart';
import 'day_model_hive.dart';
import 'trip_model_hive.dart';
// ─── Activity ───────────────────────────────────────
ActivityModelHive toHiveActivity(ActivityModel model) {
  return ActivityModelHive()
    ..cost = model.cost
    ..time = model.time
    ..landmarkName = model.landmarkName
    ..description = model.description
    ..image = model.image ?? 'assets/images/pyramid.png'
    ..lat = model.lat
    ..lng = model.lng
    ..id = model.id;  // ← was missing!
}

ActivityModel fromHiveActivity(ActivityModelHive hive) {
  return ActivityModel(
    cost: hive.cost ?? 0,
    time: hive.time ?? '',
    landmarkName: hive.landmarkName ?? '',
    description: hive.description ?? '',
    image: hive.image ?? 'assets/images/pyramid.png',
    lat: hive.lat ?? 0.0,
    lng: hive.lng ?? 0.0,
    id: hive.id ?? '',
  );
}

// ─── Day ────────────────────────────────────────────
DayModelHive toHiveDay(DayModel model) {
  return DayModelHive()
    ..totalCost = model.totalCost
    ..activities = model.activity.map(toHiveActivity).toList();
}

DayModel fromHiveDay(DayModelHive hive) {
  return DayModel(
    totalCost: hive.totalCost ?? 0,
    activity: hive.activities?.map(fromHiveActivity).toList() ?? [], // ← null safe
  );
}

// ─── Trip ───────────────────────────────────────────
TripModelHive toHiveTrip(TripModel model) {
  return TripModelHive()
    ..remoteId = model.id
    ..days = model.days
    ..title = model.title
    ..active = true  // ← always true when saving active trip
    ..dayModels = model.dayModel.map(toHiveDay).toList();
}

TripModel fromHiveTrip(TripModelHive hive) {
  return TripModel(
    id: hive.remoteId,
    days: hive.days ?? 0,
    title: hive.title ?? '',
    active: hive.active ?? false,
    dayModel: hive.dayModels?.map(fromHiveDay).toList() ?? [], // ← null safe
  );
}