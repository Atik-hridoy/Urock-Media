import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/routes/app_routes.dart';

/// Category icon widget for marketplace
class CategoryIcon extends StatelessWidget {
  final String name;
  final String icon;
  final String id;

  const CategoryIcon({
    super.key,
    required this.name,
    required this.icon,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.categoryProduct,
          arguments: {'name': name, 'id': id},
        );
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                icon,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.checkroom,
                    color: Colors.white,
                    size: 28,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),
          SizedBox(
            width: 70,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 11),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
