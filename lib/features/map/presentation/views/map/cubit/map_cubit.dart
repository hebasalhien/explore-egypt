import 'package:explore_egypt/core/services/location_services.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(super.initialState);
  final _locationService = LocationService();

  Future<void> init() async {
    await requestPermission();
  }
  
  Future<void> requestPermission() async {
    final granted = await _locationService.requestPermission();

    if (granted) {
      await getCurrentLocation();
    } else {
      if (state is MapNoPlan) {
        emit(
          MapNoPlan(
            isLoadingLocation: false,
            permissionGranted: false,
            userLat: LocationService.defaultLat,
            userLng: LocationService.defaultLng,
          ),
        );
      } else if (state is MapHasPlan) {
        emit(
          (state as MapHasPlan).copyWith(
            isLoadingLocation: false,
            permissionGranted: false,
            userLat: LocationService.defaultLat,
            userLng: LocationService.defaultLng,
          ),
        );
      }
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      if (state is MapHasPlan) {
        emit((state as MapHasPlan).copyWith(isLoadingLocation: true));
      } else {
        emit((state as MapNoPlan).copyWith(isLoadingLocation: true));
      }
      final position = await _locationService.getCurrentPosition();

      if (position != null) {
        if (state is MapHasPlan) {
          emit(
            (state as MapHasPlan).copyWith(
              isLoadingLocation: false,
              permissionGranted: true,
              userLat: position.latitude,
              userLng: position.longitude,
            ),
          );
        } else if (state is MapNoPlan) {
          emit(
            (state as MapNoPlan).copyWith(
              isLoadingLocation: false,
              permissionGranted: true,
              userLat: position.latitude,
              userLng: position.longitude,
            ),
          );
        }
      }
    } catch (e) {
      emit(MapError(errorMessage: 'Cannot get user location'));
    }
  }
}
