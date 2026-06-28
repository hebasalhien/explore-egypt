import 'package:explore_egypt/core/user/local/user_model_hive.dart';
import 'package:explore_egypt/features/map/model/local/activity_model_hive.dart';
import 'package:explore_egypt/features/map/model/local/day_model_hive.dart';
import 'package:explore_egypt/features/map/model/local/trip_model_hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _userBox = 'user_box';
  static const String _tripBox = 'trip_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    // register adapters
    Hive.registerAdapter(UserModelHiveAdapter());
    Hive.registerAdapter(ActivityModelHiveAdapter());
    Hive.registerAdapter(DayModelHiveAdapter());
    Hive.registerAdapter(TripModelHiveAdapter());

    // open boxes
    await Hive.openBox<UserModelHive>(_userBox);  
    await Hive.openBox<TripModelHive>(_tripBox);
  }

  // ─── USER ───────────────────────────────────────────

  Future<void> saveUser(UserModelHive user) async {
    debugPrint(' HIVE MESSAGE: save user success');
    final box = Hive.box<UserModelHive>(_userBox);
    await box.clear(); // only one user at a time
    await box.add(user);
  }

  Future<UserModelHive?> getUser() async {
    final box = Hive.box<UserModelHive>(_userBox);
    return box.isEmpty ? null : box.getAt(0);
  }

  Future<void> clearUser() async {
    await Hive.box<UserModelHive>(_userBox).clear();
  }

  // ─── TRIPS (max 5) ──────────────────────────────────

  Future<void> saveTrip(TripModelHive trip) async {
    final box = Hive.box<TripModelHive>(_tripBox);

    if (box.length <= 1) {
      await box.deleteAt(0); // remove oldest
    }

    await box.add(trip);
  }

  Future<List<TripModelHive>> getAllTrips() async {
    return Hive.box<TripModelHive>(_tripBox).values.toList();
  }

  Future<void> deleteTrip(int index) async {
    await Hive.box<TripModelHive>(_tripBox).deleteAt(index);
  }

  Future<void> clearAllTrips() async {
    await Hive.box<TripModelHive>(_tripBox).clear();
  }



  /// save active plan
  Future<void> saveActiveTrip(TripModelHive trip) async {
  final box = Hive.box<TripModelHive>(_tripBox);
  debugPrint('💾 saving to box: $_tripBox');
  debugPrint('💾 box isOpen: ${box.isOpen}');
  trip.active = true;
  await box.put('activeTrip', trip);
  debugPrint('💾 box length after save: ${box.length}'); // ← does this print 1?
  debugPrint('plan saved successfully');
}

Future<void> deleteActiveTrip() async {
  final box = Hive.box<TripModelHive>(_tripBox);
  await box.delete('activeTrip'); // ✅ deletes same fixed key
}

Future<TripModelHive?> getActiveTrip() async {
  final box = Hive.box<TripModelHive>(_tripBox);
  debugPrint('📦 box length: ${box.length}');
  debugPrint('📦 box keys: ${box.keys.toList()}');
  debugPrint('📦 box values: ${box.values.map((e) => 'id:${e.remoteId} active:${e.active}').toList()}');

  final trip = box.get('activeTrip'); // ✅ always reads same fixed key
  return trip; // returns null automatically if not found
}
}
