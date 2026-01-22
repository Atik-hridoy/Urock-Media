import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/core/widgets/no_data.dart';
import 'package:urock_media_movie_app/features/inbox/logic/inbox_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/message_list_item.dart';
import '../../home/widgets/bottom_nav_bar.dart';

/// Inbox/Messages screen
class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedNavIndex = 1; // Inbox is at index 1

  // Mock messages data
  // final List<Map<String, dynamic>> _messages = [
  //   {
  //     'name': 'Cody Fisher',
  //     'message': 'typing...',
  //     'time': '2d',
  //     'avatar': 'CF',
  //     'unreadCount': 0,
  //     'isTyping': true,
  //   },
  //   {
  //     'name': 'Electronics Deal Hunt',
  //     'message': 'Check out this amazing laptop deal!',
  //     'time': '1h',
  //     'avatar': 'ED',
  //     'unreadCount': 8,
  //     'isTyping': false,
  //   },
  //   {
  //     'name': 'Michael Chen',
  //     'message': 'Thanks for the recommendation!',
  //     'time': '2h',
  //     'avatar': 'MC',
  //     'unreadCount': 0,
  //     'isTyping': false,
  //   },
  //   {
  //     'name': 'Fashion Squad',
  //     'message': 'Emma: New arrivals are amazing!',
  //     'time': '5h',
  //     'avatar': 'FS',
  //     'unreadCount': 12,
  //     'isTyping': false,
  //   },
  //   {
  //     'name': 'Jessica Martir',
  //     'message': 'See you at the sale tomorrow!',
  //     'time': '2d',
  //     'avatar': 'JM',
  //     'unreadCount': 0,
  //     'isTyping': false,
  //   },
  //   {
  //     'name': 'Albert Flores',
  //     'message': 'See you at the sale tomorrow!',
  //     'time': '2d',
  //     'avatar': 'AF',
  //     'unreadCount': 0,
  //     'isTyping': false,
  //   },
  //   {
  //     'name': 'Marvin McKini',
  //     'message': 'Mike: Check out this amazing laptop deal!',
  //     'time': '2d',
  //     'avatar': 'MM',
  //     'unreadCount': 0,
  //     'isTyping': false,
  //   },
  //   {
  //     'name': 'Theresa Webb',
  //     'message': '',
  //     'time': '2d',
  //     'avatar': 'TW',
  //     'unreadCount': 0,
  //     'isTyping': false,
  //   },
  // ];

  final _controller = InboxController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.loadMessages();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Inbox',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
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
          final inbox = _controller.messages;
          if (inbox.isEmpty) {
            return NoData(
              onPressed: () => _controller.loadMessages(),
              text: "Inbox is empty",
            );
          }
          return Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search messages...',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              // Messages list
              Expanded(
                child: ListView.builder(
                  itemCount: inbox.length,
                  itemBuilder: (context, index) {
                    return MessageListItem(
                      name: inbox[index].participants.first.name,
                      message: "",
                      time: _controller.timeAgoShort(
                        inbox[index].lastMessageAt,
                      ),
                      avatar:
                          "${ApiConfig.imageUrl}${inbox[index].participants.first.image}",
                      unreadCount: inbox[index].unreadCount,
                      isTyping: false,
                      chatId: inbox[index].id,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
          _handleBottomNavTap(index);
        },
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        // Home
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // Inbox - already here
        break;
      case 2:
        // Marketplace - TODO
        break;
      case 3:
        // Live TV - TODO
        break;
      case 4:
        // Profile
        Navigator.of(context).pushReplacementNamed('/profile');
        break;
    }
  }
}
