import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/chat/data/model/message_model.dart';

class MessageRepo {
  static Future<List<MessageModel>> loadMessageRepo(String chatId) async {
    try {
      final response = await ApiService().get("${ApiEndpoints.message}$chatId");
      if (response.statusCode == 200) {
        final message = MessageResponseModel.fromJson(response.data['data']);
        return message.messages;
      }
      return [];
    } catch (e) {
      Logger.error("load message repo", e);
      return [];
    }
  }
}
