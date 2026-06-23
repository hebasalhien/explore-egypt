import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRemoteDataSource {
  final ApiService _apiService;
  WebSocketChannel? _channel;
  final _audioStreamController = StreamController<Uint8List>.broadcast();

  ChatRemoteDataSource(this._apiService);

  Future<dynamic> getConversation({
    String? conversationID,
    CancelToken? cancelToken,
  }) async {
    final response = await _apiService.dio.get(
      ApiConstants.chats + (conversationID != null ? '/$conversationID' : ''),
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> sendMessage(
    String? conversationId, {
    String? message,
    String? mode,
    List<String>? filePath,
    CancelToken? cancelToken,
  }) async {
    List<MultipartFile> files = [];

    if (filePath != null && filePath.isNotEmpty) {
      for (String path in filePath) {
        files.add(
          await MultipartFile.fromFile(path, filename: path.split('/').last),
        );
        debugPrint("this is file  $path");
      }
    }

    FormData formData = FormData.fromMap({
      if (message != null) "message": message,
      if (conversationId != null) "conversationId": conversationId,
      if (files.isNotEmpty) "files": files,
      if (mode != null) "type": mode,
    });
    final response = await _apiService.dio.post(
      ApiConstants.chats,
      data: formData,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<int> deleteConversation({required String conversationId}) async {
    final response = await _apiService.dio.delete(
      '${ApiConstants.chats}/$conversationId',
    );
    return response.statusCode!;
  }

  Future<dynamic> regenerate({required String? conversationId}) async {
    final response = await _apiService.dio.post(
      '${ApiConstants.chats}/$conversationId${ApiConstants.regenerate}',
    );
    return response.data;
  }
  
  Future<dynamic> stopGenerating({required String? conversationId}) async {
    final response = await _apiService.dio.post(
      '${ApiConstants.chats}/$conversationId${ApiConstants.stopGenerating}',
    );
    return response.data;
  }

  Stream<Uint8List> get incomingAudioStream => _audioStreamController.stream;

  
  void connectVoiceCall() {
    
    _channel = WebSocketChannel.connect(
      Uri.parse(ApiConstants.voiceCall),
    );

    // Push incoming audio into the stream
    _channel!.stream.listen(
      (data) {
        if (data is Uint8List) {
          _audioStreamController.add(data);
        }
      },
      onDone: () => _audioStreamController.close(),
      onError: (e) => _audioStreamController.addError(e),
    );
  }

  
  void sendAudioChunk(Uint8List audioChunk) {
    _channel?.sink.add(audioChunk);
  }

  
  void endVoiceCall() {
    _channel?.sink.close();
    _audioStreamController.close();
  }
}
