import 'package:flutter/material.dart';

/// Channel card widget for Live TV
class ChannelCard extends StatelessWidget {
  final String name;
  final String logo;

  const ChannelCard({
    super.key,
    required this.name,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to channel player
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                logo,
                style: TextStyle(
                  color: _getLogoColor(),
                  fontSize: _getLogoFontSize(),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getLogoColor() {
    switch (logo) {
      case 'CNN':
        return Colors.red;
      case 'ESPN':
        return Colors.red;
      case 'HBO':
        return Colors.black;
      case 'Sony':
        return Colors.green;
      case '&Prive':
        return const Color(0xFF8B0000);
      case 'VH1':
        return Colors.black;
      case '9XM':
        return Colors.purple;
      case 'DAZN':
        return Colors.black;
      case 'beIN':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  double _getLogoFontSize() {
    switch (logo) {
      case 'Univision':
        return 10;
      case 'Bein Sports':
        return 10;
      case 'VH1 Classic':
        return 10;
      default:
        return 16;
    }
  }
}
