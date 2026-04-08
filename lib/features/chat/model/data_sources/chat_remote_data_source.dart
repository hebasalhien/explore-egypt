import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class ChatRemoteDataSource {
  Future<dynamic> getConversation({String? conversationID}) async {
    final response = await ApiService.instance.dio.get(
      ApiConstants.chats + (conversationID != null ? '/$conversationID' : ''),
    );
    return response.data;
  }

  Future<dynamic> sendMessage(
    String? conversationId, {
    required String message,
  }) async {
    final response = await ApiService.instance.dio.post(
      ApiConstants.chats,
      data: {'message': message, 'conversationId': conversationId},
    );
    return response.data;
  }
}
