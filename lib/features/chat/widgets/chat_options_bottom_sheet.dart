import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/features/chat/logic/chat_controller.dart';

/// Chat options bottom sheet
class ChatOptionsBottomSheet extends StatelessWidget {
  const ChatOptionsBottomSheet({super.key});

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
              icon: Icons.notifications_off_outlined,
              title: 'Mute Conversation',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement mute functionality
              },
            ),
            // Block Conversation
            _buildOption(
              context,
              icon: Icons.block_outlined,
              title: 'Block Conversation',
              onTap: () {
                Navigator.pop(context);
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
              Navigator.pop(context);
              final isDeleted = await ChatController().deleteChat();
              if (isDeleted) {
                Navigator.pop(context);
              }
              // TODO: Implement delete functionality
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ChatOptionsBottomSheet(),
    );
  }
}
