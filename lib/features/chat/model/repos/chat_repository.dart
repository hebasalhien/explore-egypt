import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/chat/model/data_sources/chat_remote_data_source.dart';

class ChatRepository {
  final ChatRemoteDataSource _dataSource;

  ChatRepository(this._dataSource);

  Future<dynamic> getConversation({
    String? conversationID,
    CancelToken? cancelToken,
  }) async {
    try {
      final data = await _dataSource.getConversation(
        conversationID: conversationID,
        cancelToken: cancelToken,
      );
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(
        ExceptionResult(
          message: 'An unexpected error occurred',
          type: DioExceptionType2.unknown,
        ),
      );
    }
  }

  Future<dynamic> sendMessage(
    String? conversationId, {
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
      final result = ExceptionHandleHelper.handleDioException(e);

      if (e.type == DioExceptionType.cancel) {
        rethrow; // 🔥 IMPORTANT: keep cancellation intact
      }

      if (result.type == DioExceptionType2.timeout) {
        throw const TimeoutException();
      }

      throw ServerException(result);
    } catch (e) {
      throw ServerException(
        ExceptionResult(
          message: 'An unexpected error occurred: $e',
          type: DioExceptionType2.unknown,
        ),
      );
    }
  }

  Future<dynamic> deleteConversation({required String conversationId}) async {
    try {
      final data = await _dataSource.deleteConversation(
        conversationId: conversationId,
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

  Future<dynamic> regenerateLastMessage({
    required String? conversationId,
  }) async {
    try {
      final data = await _dataSource.regenerate(conversationId: conversationId);
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

  Future<dynamic> stopGenerating({required String? conversationId}) async {
    try {
      final data = await _dataSource.stopGenerating(
        conversationId: conversationId,
      );
      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        rethrow; // or just return;
      }

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

  Stream<Uint8List> getIncomingAudioStream() {
    return _dataSource.incomingAudioStream;
  }

  
  void connectVoiceCall() {
    _dataSource.connectVoiceCall();
  }

  
  void sendAudioChunk(Uint8List audioChunk) {
    _dataSource.sendAudioChunk(audioChunk);
  }

  
  void endVoiceCall() {
    _dataSource.endVoiceCall();
  }
}
