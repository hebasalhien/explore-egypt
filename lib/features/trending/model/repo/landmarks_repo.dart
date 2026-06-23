import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/trending/model/data_source/landmarks_remote_data_source.dart';

class LandmarksRepository {
  final LandmarksRemoteDataSource _dataSource;
  LandmarksRepository(this._dataSource);

  Future<dynamic> getLandmarksByCategory({required String categoryId}) async {
    try {
      final data = await _dataSource.getLandmarksByCategory(categoryId: categoryId);
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred: $e',
        type: DioExceptionType2.unknown,
      ));    }
  }

  Future<dynamic> getFavoriteLandmarks() async {
    try {
      final data = await _dataSource.getFavoriteLandmarks();
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred: $e',
        type: DioExceptionType2.unknown,
      ));    }
  }

}