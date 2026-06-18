import 'package:dio/dio.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class ChatRemoteDataSource {
  final ApiService _apiService;

  ChatRemoteDataSource(this._apiService);

  Future<dynamic> getConversation({String? conversationID}) async {
    final response = await _apiService.dio.get(
      ApiConstants.chats + (conversationID != null ? '/$conversationID' : ''),
    );
    return response.data;
  }

  Future<dynamic> sendMessage(
    String? conversationId, {
    required String message,
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
      }
    }

    FormData formData = FormData.fromMap({
      "message": message,
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

  Future<dynamic> regenerate({required String conversationId}) async {
    final response = await _apiService.dio.post(
      '${ApiConstants.chats}/$conversationId${ApiConstants.regenerate}',
    );
    return response.data;
  }
}
