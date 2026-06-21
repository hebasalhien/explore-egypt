part of 'map_cubit.dart';

sealed class MapState {}

final class MapInitial extends MapState {}

final class MapHasPlan extends MapState {
  final List<LandmarkModel> landmarks;
  final int dayNumber;
  final String planName;

  // Location fields
  final bool isLoadingLocation;
  final bool permissionGranted;
  final double? userLat;
  final double? userLng;
  MapHasPlan({
    required this.landmarks,
    required this.dayNumber,
    required this.planName,
    required this.isLoadingLocation,
    required this.permissionGranted,
    required this.userLat,
    required this.userLng,
  });

  MapHasPlan copyWith({
    List<LandmarkModel>? landmarks,
    int? dayNumber,
    String? planName,
    bool? isLoadingLocation,
    bool? permissionGranted,
    double? userLat,
    double? userLng,
    String? errorMessage,
  }) {
    return MapHasPlan(
      landmarks: landmarks ?? this.landmarks,
      dayNumber: dayNumber ?? this.dayNumber,
      planName: planName ?? this.planName,
      isLoadingLocation: isLoadingLocation ?? this.isLoadingLocation,
      permissionGranted: permissionGranted ?? this.permissionGranted,
      userLat: userLat ?? this.userLat,
      userLng: userLng ?? this.userLng,
    );
  }
}

final class MapNoPlan extends MapState {
  // Location fields
  final bool isLoadingLocation;
  final bool permissionGranted;
  final double? userLat;
  final double? userLng;

  MapNoPlan({
    required this.isLoadingLocation,
    required this.permissionGranted,
    required this.userLat,
    required this.userLng,
  });

  MapNoPlan copyWith({
    bool? isLoadingLocation,
    bool? permissionGranted,
    double? userLat,
    double? userLng,
    String? errorMessage,
  }) {
    return MapNoPlan(
      isLoadingLocation: isLoadingLocation ?? this.isLoadingLocation,
      permissionGranted: permissionGranted ?? this.permissionGranted,
      userLat: userLat ?? this.userLat,
      userLng: userLng ?? this.userLng,
    );
  }
}

final class MapError extends MapState {
  final String errorMessage;

  MapError({required this.errorMessage});
}
