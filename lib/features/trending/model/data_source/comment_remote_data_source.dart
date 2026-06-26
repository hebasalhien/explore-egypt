import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class CommentRemoteDataSource {
  final ApiService _apiService;
  CommentRemoteDataSource(this._apiService);

  Future<dynamic> getLandmarkComments({required String landmarkId}) async {
    final response = await _apiService.dio.get(
      '${ApiConstants.landmarks}/$landmarkId${ApiConstants.comments}',
    );
    return response.data;
  }

  Future<dynamic> addComment({
    required String landmarkId,
    required String message,
    required double rating,
  }) async {
    final response = await _apiService.dio.post(
      '${ApiConstants.landmarks}/$landmarkId${ApiConstants.comments}',
      data: {'message': message, 'rating': rating},
    );
    return response.data;
  }
}
