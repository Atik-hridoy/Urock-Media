import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/inbox/data/model/chat_model.dart';

class ChatRepository {
  static Future<ChatResponseModel> fetchChatRepo(int page) async {
    try {
      final response = await ApiService().get(
        ApiEndpoints.chat,
        queryParameters: {'page': page, 'limit': 20},
      );
      if (response.statusCode == 200) {
        final chats = ChatResponseModel.fromJson(response.data['data']);
        return chats;
      }
      return ChatResponseModel.empty();
    } catch (e) {
      Logger.error("get chat repo", e);
      return ChatResponseModel.empty();
    }
  }
}
