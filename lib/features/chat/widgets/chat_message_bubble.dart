import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/constants/app_sizes.dart';
import 'package:urock_media_movie_app/features/chat/widgets/image_preview_screen.dart';
import '../../../core/constants/app_colors.dart';

/// Chat message bubble widget
class ChatMessageBubble extends StatelessWidget {
  final String? text;
  final bool isMe;
  final String time;
  final String? avatar;
  final String? image;

  const ChatMessageBubble({
    super.key,
    this.text,
    required this.isMe,
    required this.time,
    this.avatar,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Time stamp
          if (!isMe && text != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ),
          // Message bubble
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe && avatar != null) ...[
                SizedBox(
                  width: AppSizes.iconLG,
                  height: AppSizes.iconLG,

                  child: ClipOval(
                    child: Image.network(
                      avatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: _getAvatarColor(),
                            child: Text(
                              avatar!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: image != null
                    ? _buildImageMessage(context)
                    : _buildTextMessage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isMe ? AppColors.goldLight : const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          color: isMe ? Colors.black : Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (image == null || image!.isEmpty) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImagePreviewScreen(imageUrl: image!),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple[700]!, Colors.blue[700]!],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            image ?? "",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Stack(
              children: [
                // Placeholder for laptop image
                Center(
                  child: Icon(
                    Icons.laptop_mac,
                    size: 60,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                // Gradient overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getAvatarColor() {
    if (avatar == null) return Colors.grey;

    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
    ];
    final index = avatar!.codeUnitAt(0) % colors.length;
    return colors[index];
  }
}
