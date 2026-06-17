import 'package:explore_egypt/features/map/model/data_source/map_remote_data_source.dart';

class MapRepository {

final MapRemoteDataSource _mapRemoteDataSource;
MapRepository(this._mapRemoteDataSource);

Future<dynamic> getAllMyPlans() async {
  return await _mapRemoteDataSource.getAllMyPlans();
}

Future<dynamic> deletePlan({required String tripId}) async {
  return await _mapRemoteDataSource.deletePlan(tripId: tripId);
}


}