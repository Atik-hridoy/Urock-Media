import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/core/constants/app_sizes.dart';
import 'package:urock_media_movie_app/core/services/storage_service.dart';
import 'package:urock_media_movie_app/core/widgets/no_data.dart';
import 'package:urock_media_movie_app/features/chat/logic/chat_controller.dart';
import 'package:urock_media_movie_app/features/inbox/logic/inbox_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/chat_options_bottom_sheet.dart';

/// Chat screen for individual conversations
class ChatScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final String chatId;

  const ChatScreen({
    super.key,
    required this.name,
    required this.avatar,
    required this.chatId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock chat messages
  // final List<Map<String, dynamic>> _messages = [
  //   {
  //     'text': 'Hey everyone! Found an amazing deal on laptops',
  //     'isMe': false,
  //     'time': '1:13 PM',
  //     'avatar': 'P',
  //   },
  //   {'text': 'What\'s the deal?', 'isMe': true, 'time': '1:13 PM'},
  //   {'image': 'laptop_image', 'isMe': false, 'time': '1:14 PM', 'avatar': 'P'},
  //   {
  //     'text': 'Emma: That\'s an insane price!',
  //     'isMe': false,
  //     'time': '1:15 PM',
  //     'avatar': 'E',
  //   },
  //   {'text': 'Wow! 40% off?! 😍', 'isMe': true, 'time': '1:15 PM'},
  //   {
  //     'text': 'Mike: Right? It\'s normally \$2199',
  //     'isMe': false,
  //     'time': '1:16 PM',
  //     'avatar': 'M',
  //   },
  //   {
  //     'text': 'James: Just grabbed one!\nThanks Mike!',
  //     'isMe': false,
  //     'time': '1:17 PM',
  //     'avatar': 'J',
  //   },
  //   {'text': 'How long is this deal valid?', 'isMe': true, 'time': '1:18 PM'},
  //   {
  //     'text': 'Mike: Until midnight tonight. Only 15 left in stock!',
  //     'isMe': false,
  //     'time': '1:18 PM',
  //     'avatar': 'M',
  //   },
  // ];

  final _controller = ChatController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.chatId = widget.chatId;
    _controller.loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _openGallery() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    if (picker != null) {
      _controller.sendImage(File(picker.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            SizedBox(
              width: AppSizes.iconXL,
              height: AppSizes.iconXL,
              child: ClipOval(
                child: Image.network(
                  widget.avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue,
                    child: Text(
                      "A",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Active now',
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // if (_controller.isMuted)
          //   IconButton(
          //     icon: const Icon(Icons.notifications_off, color: Colors.white),
          //     onPressed: () {
          //       _controller.muteChat();
          //     },
          //   ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              ChatOptionsBottomSheet.show(context);
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.white,
              ),
            );
          }

          final allMessage = _controller.messages;
          if (allMessage.isEmpty) {
            return NoData(onPressed: () => _controller.loadMessages());
          }
          return Column(
            children: [
              // Messages list
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: allMessage.length,
                  itemBuilder: (context, index) {
                    print("my id: ${StorageService.getUserData()}");
                    return ChatMessageBubble(
                      text: allMessage[index].text,
                      isMe:
                          allMessage[index].sender.id ==
                          StorageService.getUserData()!['id'],
                      time: InboxController().timeAgoShort(
                        allMessage[index].createdAt,
                      ),
                      avatar:
                          "${ApiConfig.imageUrl}${allMessage[index].sender.image}",
                      image: allMessage[index].images.isNotEmpty
                          ? "${ApiConfig.imageUrl}${allMessage[index].images.first}"
                          : null,
                    );
                  },
                ),
              ),
              // Input field
              ChatInputField(
                controller: _messageController,
                onSend: () {
                  _controller.sendMessage(_messageController.text);
                  _messageController.clear();
                },
                onSendImage: _openGallery,
              ),
            ],
          );
        },
      ),
    );
  }
}
