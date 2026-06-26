import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/trending/model/data_source/comment_remote_data_source.dart';

class CommentRepo {
  final CommentRemoteDataSource _dataSource;
  CommentRepo(this._dataSource);

  Future<dynamic> getLandmarkComments({required String landmarkId}) async {
    try {
      final data = await _dataSource.getLandmarkComments(
        landmarkId: landmarkId,
      );
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(
        ExceptionResult(
          message: 'An unexpected error occurred: $e',
          type: DioExceptionType2.unknown,
        ),
      );
    }
  }

  Future<dynamic> addNewComment({
    required String landmarkId,
    required String message,
    required double rating,
  }) async {
    try {
      final data = await _dataSource.addComment(
        landmarkId: landmarkId,
        message: message,
        rating: rating,
      );
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(
        ExceptionResult(
          message: 'An unexpected error occurred: $e',
          type: DioExceptionType2.unknown,
        ),
      );
    }
  }
}
