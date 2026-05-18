import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/core/errors/failure.dart';
import 'package:explore_egypt/features/chat/model/data_sources/chat_remote_data_source.dart';

class ChatRepository {
  final ChatRemoteDataSource _dataSource;

  ChatRepository(this._dataSource);
    Future<dynamic> getConversation({String? conversationID} ) async {
    try {
      final data = await _dataSource.getConversation(conversationID: conversationID);
      return data;
    } 
    on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }

   Future<dynamic> sendMessage(
    String? conversationId , {
    required String message,
    List<String>? filePath,
    String? mode,
    CancelToken? cancelToken,
  }) async {
    try {
      final data = await _dataSource.sendMessage(
        conversationId, 
        message: message,
        filePath: filePath,
        mode: mode,
        cancelToken: cancelToken,
      );
      return data;
    } on DioException catch (e) {
      throw ServerFailure(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerFailure('An unexpected error occurred: $e');
    }
  }
}
