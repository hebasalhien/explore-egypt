import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/plans/model/data_source/suggested_plans_remote_data_source.dart';

class SuggestedPlansRepo {
  final SuggestedPlansRemoteDataSource _dataSource;
  SuggestedPlansRepo(this._dataSource);

  Future<dynamic> getPlansByCategory({required String categoryId}) async {
    try {
      final data = await _dataSource.getPlansByCategory(categoryId: categoryId);
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred: $e',
        type: DioExceptionType2.unknown,
      ));    }
  }

  Future<dynamic> getFavoritePlans() async {
    try {
      final data = await _dataSource.getFavoritePlans();
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