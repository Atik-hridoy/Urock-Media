import 'package:flutter/material.dart';
import 'episode_card.dart';

/// Episodes section with season selector
class EpisodesSection extends StatefulWidget {
  const EpisodesSection({super.key});

  @override
  State<EpisodesSection> createState() => _EpisodesSectionState();
}

class _EpisodesSectionState extends State<EpisodesSection> {
  String _selectedSeason = 'Stranger Things';
  bool _isDropdownOpen = false;

  final List<String> _seasons = [
    'Season 1',
    'Season 2',
    'Season 3',
  ];

  final List<Map<String, String>> _episodes = [
    {
      'title': '1. Chapter One: The Vanishing of Will Byers',
      'duration': '49m',
    },
    {
      'title': 'Chapter Two: The Weirdo on Maple Street',
      'duration': '49m',
    },
    {
      'title': 'Chapter Three: Holly, Jolly',
      'duration': '49m',
    },
    {
      'title': 'Chapter Five: The Flea and the Acrobat',
      'duration': '49m',
    },
    {
      'title': 'Chapter Six: The Monster',
      'duration': '49m',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Episodes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          // Divider
          Container(
            height: 1,
            color: const Color(0xFFCF9702),
          ),
          const SizedBox(height: 16),
          // Season Selector with dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isDropdownOpen = !_isDropdownOpen;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedSeason,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      _isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
              if (_isDropdownOpen) ...[
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _seasons.map((season) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedSeason = season;
                            _isDropdownOpen = false;
                          });
                        },
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Text(
                            season,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          // Episodes List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _episodes.length,
            itemBuilder: (context, index) {
              return EpisodeCard(
                title: _episodes[index]['title']!,
                duration: _episodes[index]['duration']!,
                episodeNumber: index + 1,
              );
            },
          ),
        ],
      ),
    );
  }
}
