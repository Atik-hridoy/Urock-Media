import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/constants/app_strings.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/services/storage_service.dart';
import 'package:urock_media_movie_app/features/chat/data/model/message_model.dart';
import 'package:urock_media_movie_app/features/chat/data/repository/message_repo.dart';
import '../../../core/utils/logger.dart';

/// Controller for chat screen logic
class ChatController extends ChangeNotifier {
  List<MessageModel> _messages = [];
  bool _isLoading = false;

  String chatId = "";

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;

  /// Load chat messages
  Future<void> loadMessages(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      Logger.info('Loading messages for chat: $chatId');
      // TODO: Implement actual API call

      _messages = await MessageRepo.loadMessageRepo(chatId);
    } catch (e, stackTrace) {
      Logger.error('Failed to load messages', e, stackTrace);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Send message
  Future<void> sendMessage(String text) async {
    Logger.info('Sending message: $text');
    // TODO: Implement send message functionality
    final body = FormData.fromMap({
      'data': jsonEncode({'text': text}),
      'type': 'text',
    });
    await ApiService().post("${ApiEndpoints.sendMessage}$chatId", data: body);
    _messages.insert(
      0,
      MessageModel.empty().copyWith(
        text: text,
        sender: MessageSenderModel(
          id: StorageService.getUserData()!['id'],
          name: "name",
          email: "email",
          image: "image",
        ),
      ),
    );
    // _messages.add(
    // MessageModel(
    //   text: text,
    //   isMe: true,
    //   tme: "1:17 PM",
    //   profile:
    //       "/image/e9f91bc1-6e50-446e-88f8-4ddae060dcee7643013136875769897-1768986348709.jpg",
    // ),
    // );
    notifyListeners();
  }

  /// Send image
  Future<void> sendImage(File image) async {
    Logger.info('Sending image: ${image.path}');
    // TODO: Implement send image functionality
    final body = FormData.fromMap({
      'images': await MultipartFile.fromFile(image.path),
      'type': 'image',
    });
    final response = await ApiService().post(
      "${ApiEndpoints.sendMessage}$chatId",
      data: body,
    );
    if (response.statusCode == 200) {
      _messages.insert(
        0,
        MessageModel.empty().copyWith(
          images: [(response.data['data']['images'] as List).first],
          sender: MessageSenderModel(
            id: StorageService.getUserData()!['id'],
            name: "name",
            email: "email",
            image: "image",
          ),
        ),
      );
    }

    notifyListeners();
  }

  String formatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return DateFormat('h:mm a').format(DateTime.now());
    }
    return DateFormat('h:mm a').format(dateTime);
  }

  Future<bool> deleteChat(String chatId) async {
    try {
      final response = await ApiService().delete(
        "${ApiEndpoints.chatDelete}$chatId",
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      Logger.error("delete chat", e);
      return false;
    }
  }

  Future<bool> muteChat(String chatId) async {
    try {
      final response = await ApiService().patch(
        "${ApiEndpoints.muteChat}$chatId",
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      Logger.error("mute chat", e);
      return false;
    }
  }

  Future<bool> blockUser(String chatId, String userId, bool isBlocked) async {
    if (userId == StorageService.getUserData()!['id']) {
      return false;
    }
    try {
      final response = await ApiService().patch(
        "${ApiEndpoints.blockUser}$chatId/$userId",
        data: {"action": isBlocked ? "Unblock" : "block"},
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      Logger.error("blocked user", e);
      return false;
    }
  }
}
