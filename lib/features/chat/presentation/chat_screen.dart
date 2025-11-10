import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/chat_options_bottom_sheet.dart';

/// Chat screen for individual conversations
class ChatScreen extends StatefulWidget {
  final String name;
  final String avatar;

  const ChatScreen({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock chat messages
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hey everyone! Found an amazing deal on laptops',
      'isMe': false,
      'time': '1:13 PM',
      'avatar': 'P',
    },
    {
      'text': 'What\'s the deal?',
      'isMe': true,
      'time': '1:13 PM',
    },
    {
      'image': 'laptop_image',
      'isMe': false,
      'time': '1:14 PM',
      'avatar': 'P',
    },
    {
      'text': 'Emma: That\'s an insane price!',
      'isMe': false,
      'time': '1:15 PM',
      'avatar': 'E',
    },
    {
      'text': 'Wow! 40% off?! 😍',
      'isMe': true,
      'time': '1:15 PM',
    },
    {
      'text': 'Mike: Right? It\'s normally \$2199',
      'isMe': false,
      'time': '1:16 PM',
      'avatar': 'M',
    },
    {
      'text': 'James: Just grabbed one!\nThanks Mike!',
      'isMe': false,
      'time': '1:17 PM',
      'avatar': 'J',
    },
    {
      'text': 'How long is this deal valid?',
      'isMe': true,
      'time': '1:18 PM',
    },
    {
      'text': 'Mike: Until midnight tonight. Only 15 left in stock!',
      'isMe': false,
      'time': '1:18 PM',
      'avatar': 'M',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
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
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue,
              child: Text(
                widget.avatar,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              ChatOptionsBottomSheet.show(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatMessageBubble(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                  avatar: message['avatar'],
                  hasImage: message['image'] != null,
                );
              },
            ),
          ),
          // Input field
          ChatInputField(
            controller: _messageController,
            onSend: _handleSendMessage,
          ),
        ],
      ),
    );
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    // TODO: Send message
    _messageController.clear();
  }
}
