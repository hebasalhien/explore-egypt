import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';

class MapRemoteDataSource {
  final ApiService _apiService;

  MapRemoteDataSource(this._apiService);

  Future<dynamic> getAllMyPlans() async {
    final response = await _apiService.dio.get(ApiConstants.plan);
    return response.data;
  }

  Future<dynamic> savePlan({required TripModel trip}) async {
    final response = await _apiService.dio.post(
      ApiConstants.savePlan,
      data: {},
    );
    return response.data;
  }

  Future<dynamic> deletePlan({required String tripId}) async {
    final response = await _apiService.dio.delete(
      '${ApiConstants.plan}/$tripId',
    );
    return response.data;
  }
}