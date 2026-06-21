import 'package:explore_egypt/features/map/model/data_source/map_remote_data_source.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';

class MapRepository {

final MapRemoteDataSource _mapRemoteDataSource;
MapRepository(this._mapRemoteDataSource);

Future<List<TripModel>> getAllMyPlans() async {
  final data = await _mapRemoteDataSource.getAllMyPlans();
      final List<TripModel> plans = (data as List)
          .map((x) => TripModel.fromJson(x))
          .toList();
          return plans;
}

Future<dynamic> getActivePlan() async {
  return await _mapRemoteDataSource.getActivePlan();
}

Future<dynamic> deletePlan({required String tripId}) async {
  return await _mapRemoteDataSource.deletePlan(tripId: tripId);
}

Future<dynamic> activatePlan({required String newPlanId, String? currentPlanId}) async {
  return await _mapRemoteDataSource.activatePlan(newPlanId: newPlanId, currentPlanId: currentPlanId);
}
}