import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';

class ChatServices {


  static Future<dynamic> getConversation({String? conversationID} ) async {
    try {
      final response = await ApiService().dio.get(
        ApiConstants.chats+(conversationID != null ? '/$conversationID' : ''),
        
      );
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  static Future<dynamic> sendMessage(
    String? conversationId , {
    required String message,
  }) async {
    try {
      final response = await ApiService().dio.post(
        ApiConstants.chats,
        data: {
          'message': message,
          'conversationId': conversationId,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
