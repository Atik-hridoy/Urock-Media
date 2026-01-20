import 'package:flutter/foundation.dart';
import 'package:urock_media_movie_app/features/inbox/data/model/chat_model.dart';
import '../../../core/utils/logger.dart';

/// Controller for inbox screen logic
class InboxController extends ChangeNotifier {
  List<ChatModel> _messages = [];
  bool _isLoading = false;

  List<ChatModel> get messages => _messages;
  bool get isLoading => _isLoading;

  /// Load messages
  Future<void> loadMessages() async {
    _isLoading = true;
    notifyListeners();

    try {
      Logger.info('Loading messages');
      // TODO: Implement actual API call

      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      Logger.error('Failed to load messages', e, stackTrace);
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Mark message as read
  void markAsRead(String messageId) {
    Logger.info('Marking message as read: $messageId');
    // TODO: Implement mark as read functionality
    notifyListeners();
  }

  /// Delete message
  void deleteMessage(String messageId) {
    Logger.info('Deleting message: $messageId');
    // TODO: Implement delete functionality
    notifyListeners();
  }
}
