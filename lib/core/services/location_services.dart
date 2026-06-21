import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Singleton pattern so it's reused across the app
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  static const double defaultLat = 30.0444; // Cairo
  static const double defaultLng = 31.2357;
  
Future<bool> requestPermission() async {
  // Check if location service is enabled first
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Opens device location settings so user can enable GPS
    await Geolocator.openLocationSettings();
    return false;
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    // Shows the permission dialog
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    // Permission permanently denied — open app settings
    await Geolocator.openAppSettings();
    return false;
  }

  return permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;
}

  Future<Position?> getCurrentPosition() async {
    try {
      final permission = await _checkPermission();
      if (!permission) return null;

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10), // optional timeout
        ),
      );
    } catch (e, st) {
  debugPrint('Location error: $e');
  debugPrintStack(stackTrace: st);
  return null;
}
  }

  Future<bool> _checkPermission() async {
    // Check if location service is enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<bool> isPermissionGranted() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> openSettings() async {
    await Geolocator.openLocationSettings();
  }
}
