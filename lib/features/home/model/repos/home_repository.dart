import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/home/model/data_sources/home_remote_data_source.dart';

class HomeRepository {
  final HomeRemoteDataSource _dataSource;
  
  HomeRepository(this._dataSource);

  Future<dynamic> getHome() async {
    try {
      final data = await _dataSource.getHome();
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred: $e',
        type: DioExceptionType2.unknown,
      ));    }
  }

  Future<dynamic> getCategories() async {
    try {
      final data = await _dataSource.getCategories();
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
