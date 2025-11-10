import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/channel_card.dart';

/// Live TV screen with channel categories
class LiveTvScreen extends StatefulWidget {
  const LiveTvScreen({super.key});

  @override
  State<LiveTvScreen> createState() => _LiveTvScreenState();
}

class _LiveTvScreenState extends State<LiveTvScreen> {
  int _selectedNavIndex = 3; // Live TV is at index 3

  // Mock channel data
  final Map<String, List<Map<String, String>>> _channels = {
    'Popular Tv Channels': [
      {'name': 'HBO', 'logo': 'HBO'},
      {'name': 'CNN', 'logo': 'CNN'},
      {'name': 'Univision', 'logo': 'Univision'},
    ],
    'Sports': [
      {'name': 'HBO', 'logo': 'DAZN'},
      {'name': 'ESPN', 'logo': 'ESPN'},
      {'name': 'Bein Sports', 'logo': 'beIN'},
    ],
    'Music': [
      {'name': 'VH1', 'logo': 'VH1'},
      {'name': 'VH1 Classic', 'logo': 'VH1'},
      {'name': '9xm', 'logo': '9XM'},
    ],
    'Movies': [
      {'name': 'HBO', 'logo': 'HBO'},
      {'name': '& Prive', 'logo': '&Prive'},
      {'name': 'Univision', 'logo': 'Sony'},
    ],
    'Religious': [
      {'name': 'Univision', 'logo': 'Sony'},
      {'name': 'HBO', 'logo': 'HBO'},
      {'name': '& Prive', 'logo': '&Prive'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.grid_view, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamed('/channel-categories');
          },
        ),
        title: const Text(
          'Live Tv',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _channels.entries.map((entry) {
              return _buildChannelSection(entry.key, entry.value);
            }).toList(),
          ),
        ),
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

  Widget _buildChannelSection(String title, List<Map<String, String>> channels) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: channels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < channels.length - 1 ? 12 : 0,
                ),
                child: ChannelCard(
                  name: channels[index]['name']!,
                  logo: channels[index]['logo']!,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        // Home
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // Inbox
        Navigator.of(context).pushReplacementNamed('/inbox');
        break;
      case 2:
        // Marketplace - TODO
        break;
      case 3:
        // Live TV - already here
        break;
      case 4:
        // Profile
        Navigator.of(context).pushReplacementNamed('/profile');
        break;
    }
  }
}
