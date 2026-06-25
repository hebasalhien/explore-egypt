import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRemoteDataSource {
  final ApiService _apiService;
  WebSocketChannel? _channel;
  StreamController<Uint8List> _audioStreamController =
      StreamController<Uint8List>(); // single-subscriber; buffers data until cubit subscribes

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

  
  Future<void> connectVoiceCall() async {
    // Re-create the controller so it works after a previous endVoiceCall() closed it.
    // Use a plain (non-broadcast) controller so data is buffered until the cubit subscribes.
    if (_audioStreamController.isClosed) {
      _audioStreamController = StreamController<Uint8List>();
      debugPrint('[VoiceCall] 🔄 Audio stream controller re-created');
    }

    // Trim to handle any accidental whitespace in the .env value.
    final url = ApiConstants.voiceUrl.trim();
    debugPrint('[VoiceCall] ⏳ Connecting to WebSocket: "$url"');

    _channel = WebSocketChannel.connect(Uri.parse(url));

    // Wait for the handshake to complete before doing anything else.
    // channel.ready throws a WebSocketChannelException if the connection fails.
    try {
      await _channel!.ready;
      debugPrint('[VoiceCall] ✅ WebSocket connected successfully');
    } catch (e) {
      debugPrint('[VoiceCall] ❌ WebSocket connection failed: $e');
      rethrow;
    }

    // Push incoming audio into the stream.
    // web_socket_channel delivers binary frames as List<int>, NOT Uint8List —
    // so we must cast rather than type-check with `is Uint8List`.
    _channel!.stream.listen(
      (data) {
        Uint8List bytes;
        if (data is Uint8List) {
          bytes = data;
        } else if (data is List<int>) {
          bytes = Uint8List.fromList(data);
        } else if (data is String) {
          // Server sent a text frame — log it and skip audio forwarding
          debugPrint('[VoiceCall] 📨 Server text frame: "$data"');
          return;
        } else {
          debugPrint('[VoiceCall] ⚠️ Unexpected frame type: ${data.runtimeType} — skipping');
          return;
        }

        // Small frames (< 64 bytes) are almost certainly JSON status messages — decode them
        if (bytes.length < 64) {
          try {
            final text = utf8.decode(bytes);
            debugPrint('[VoiceCall] 📨 Server status frame (${bytes.length} bytes): "$text"');
          } catch (_) {
            debugPrint('[VoiceCall] 📥 Small binary frame (${bytes.length} bytes) — not UTF-8');
          }
          // Do NOT forward tiny status frames as audio
          return;
        }

        debugPrint('[VoiceCall] 🔊 Audio bytes forwarded to stream: ${bytes.length} bytes');
        _audioStreamController.add(bytes);
      },
      onDone: () {
        debugPrint('[VoiceCall] 🔌 WebSocket closed by server');
        if (!_audioStreamController.isClosed) _audioStreamController.close();
      },
      onError: (e) {
        debugPrint('[VoiceCall] ❌ WebSocket stream error: $e');
        _audioStreamController.addError(e);
      },
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
