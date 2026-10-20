import 'package:flutter/material.dart';
import '../models/item.dart';
import '../utils/format.dart';

// R18 & R19: Reusable card with Stack avatar, badge, title (2 lines ellipsis)
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onFavouriteToggle,
  });

  final Item item;
  final VoidCallback onTap;
  final VoidCallback onFavouriteToggle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final catColor = item.category.getColor(scheme);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // R19: Stack Avatar with Positioned badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: catColor.withOpacity(0.2),
                    child: Icon(item.category.icon, color: catColor),
                  ),
                  if (item.isFull)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: scheme.error,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'FULL',
                          style: TextStyle(color: scheme.onError, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  else if (item.freePlaces <= 5)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: scheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${item.freePlaces} left',
                          style: TextStyle(color: scheme.onTertiaryContainer, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Expanded Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${AppFormat.date(item.when)} • ${item.mode ? "Online" : "Venue"}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // Favourite button
              IconButton(
                icon: Icon(
                  item.favourite ? Icons.favorite : Icons.favorite_border,
                  color: item.favourite ? scheme.primary : null,
                ),
                onPressed: onFavouriteToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}