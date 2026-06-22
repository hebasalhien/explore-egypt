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
    ..image = model.image??'assets/images/pyramid.png'
    ..lat = model.lat
    ..lng = model.lng;
}

ActivityModel fromHiveActivity(ActivityModelHive hive) {
  return ActivityModel(
    cost: hive.cost,
    time: hive.time,
    landmarkName: hive.landmarkName,
    description: hive.description,
    image: hive.image,
    lat: hive.lat,
    lng: hive.lng,
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
    totalCost: hive.totalCost,
    activity: hive.activities.map(fromHiveActivity).toList(),
  );
}

// ─── Trip ───────────────────────────────────────────
TripModelHive toHiveTrip(TripModel model) {
  return TripModelHive()
    ..remoteId = model.id
    ..days = model.days
    ..title = model.title
    ..active = model.active
    ..dayModels = model.dayModel.map(toHiveDay).toList();
}

TripModel fromHiveTrip(TripModelHive hive) {
  return TripModel(
    id: hive.remoteId,
    days: hive.days,
    title: hive.title,
    active: hive.active,
    dayModel: hive.dayModels.map(fromHiveDay).toList(),
  );
}