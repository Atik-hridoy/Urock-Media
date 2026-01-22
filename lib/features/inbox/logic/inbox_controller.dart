import 'package:flutter/foundation.dart';
import 'package:urock_media_movie_app/features/inbox/data/model/chat_model.dart';
import 'package:urock_media_movie_app/features/inbox/data/repository/chat_repository.dart';
import '../../../core/utils/logger.dart';

/// Controller for inbox screen logic
class InboxController extends ChangeNotifier {
  ChatResponseModel messagesResponse = ChatResponseModel.empty();
  List<ChatModel> messages = [];
  bool isLoading = false;
  int page = 1;
  bool hasMore = true;

  /// Load messages
  Future<void> loadMessages() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();
    if (page == 1) {
      messages.clear();
    }
    try {
      Logger.info('Loading messages');
      // TODO: Implement actual API call
      messagesResponse = await ChatRepository.fetchChatRepo(page);
      messages.addAll(messagesResponse.chats);
      page++;
      if (messages.isEmpty || messages.length < 20) {
        hasMore = false;
      }
    } catch (e, stackTrace) {
      Logger.error('Failed to load messages', e, stackTrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future onRefresh() async {
    page = 1;
    hasMore = true;
    messages.clear();
    loadMessages();
  }

  /// Mark message as read
  void markAsRead(String messageId) {
    Logger.info('Marking message as read: $messageId');
    // TODO: Implement mark as read functionality
    notifyListeners();
  }

  // /// Delete message
  // void deleteMessage(String messageId) {
  //   Logger.info('Deleting message: $messageId');
  //   // TODO: Implement delete functionality
  //   notifyListeners();
  // }

  String timeAgoShort(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()}w';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()}mo';
    } else {
      return '${(diff.inDays / 365).floor()}y';
    }
  }

  void searchMessage(String message) async {
    isLoading = true;
    notifyListeners();
    try {
      Logger.info('Loading search messages');

      messagesResponse = await ChatRepository.fetchSearchChatRepo(message);
      messages = messagesResponse.chats;
    } catch (e, stackTrace) {
      Logger.error('Failed to load messages', e, stackTrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
