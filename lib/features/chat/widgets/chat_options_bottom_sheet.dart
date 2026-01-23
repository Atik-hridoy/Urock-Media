import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/features/chat/logic/chat_controller.dart';

/// Chat options bottom sheet
class ChatOptionsBottomSheet extends StatelessWidget {
  const ChatOptionsBottomSheet({
    super.key,
    required this.chatId,
    required this.userId,
    required this.isMuted,
    required this.isBlocked,
    required this.onMuted,
  });
  final String chatId;
  final String userId;
  final bool isMuted;
  final bool isBlocked;
  final VoidCallback onMuted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2C2C2C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Mute Conversation
            _buildOption(
              context,
              icon: !isMuted
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
              title: isMuted ? 'Unmute Conversation' : 'Mute Conversation',
              onTap: () {
                Navigator.pop(context);
                onMuted();
                // TODO: Implement mute functionality
              },
            ),
            // Block Conversation
            _buildOption(
              context,
              icon: Icons.block_outlined,
              title: isBlocked ? 'Unblock Conversation' : 'Block Conversation',
              onTap: () {
                Navigator.pop(context);
                ChatController().blockUser(chatId, userId, isBlocked);
                // TODO: Implement block functionality
              },
            ),
            // Delete Conversation
            _buildOption(
              context,
              icon: Icons.delete_outline,
              title: 'Delete Conversation',
              isDestructive: true,
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isDestructive ? Colors.red : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text(
          'Delete Conversation',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this conversation? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context); // cache BEFORE await

              navigator.pop(); // first pop

              final isDeleted = await ChatController().deleteChat(chatId);

              if (isDeleted) {
                navigator.pop(); // safe
                navigator.pop();
              }

              // TODO: Implement delete functionality
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String chatId,
    required String userId,
    required bool isBlocked,
    required bool isMuted,
    required VoidCallback onMuted,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ChatOptionsBottomSheet(
        chatId: chatId,
        userId: userId,
        isBlocked: isBlocked,
        isMuted: isMuted,
        onMuted: onMuted,
      ),
    );
  }
}
