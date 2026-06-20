import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/chat/model/data_sources/chat_remote_data_source.dart';

class ChatRepository {
  final ChatRemoteDataSource _dataSource;

  ChatRepository(this._dataSource);

    Future<dynamic> getConversation({String? conversationID, CancelToken? cancelToken} ) async {
    try {
      final data = await _dataSource.getConversation(conversationID: conversationID, cancelToken: cancelToken);
      return data;
    } 
    on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred',
        type: DioExceptionType2.unknown,
      ));
    }
  }

   Future<dynamic> sendMessage(
    String? conversationId , {
    String? message,
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
      final reselt = ExceptionHandleHelper.handleDioException(e);
      if(reselt.type == DioExceptionType2.timeout){
        throw const TimeoutException();
      }
      throw ServerException(reselt);
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred: $e',
        type: DioExceptionType2.unknown,
      ));
    }
  }

  Future<dynamic> deleteConversation({required String conversationId}) async {
    try {
      final data = await _dataSource.deleteConversation(conversationId: conversationId);
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred: $e',
        type: DioExceptionType2.unknown,
      ));
    }
  }

Future<dynamic> regenerateLastMessage({required String? conversationId}) async{
      try {
      final data = await _dataSource.regenerate(conversationId: conversationId);
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
        message: 'An unexpected error occurred: $e',
        type: DioExceptionType2.unknown,
      ));
    }
}
}
