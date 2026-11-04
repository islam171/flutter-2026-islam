import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/course_card.dart';
import '../widgets/empty_state.dart';

class FavouritesTab extends StatelessWidget {
  const FavouritesTab({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.onFavouriteToggle,
  });

  final List<Item> items;
  final ValueChanged<Item> onItemTap;
  final ValueChanged<Item> onFavouriteToggle;

  @override
  Widget build(BuildContext context) {
    final favs = items.where((i) => i.favourite).toList();

    if (favs.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.favorite_border,
        message: 'No favourite courses yet. Tap the heart icon on any course to bookmark it.',
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              mainAxisExtent: 100,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final item = favs[index];
              return CourseCard(
                item: item,
                onTap: () => onItemTap(item),
                onFavouriteToggle: () => onFavouriteToggle(item),
              );
            },
          );
        }
        return ListView.builder(
          itemCount: favs.length,
          itemBuilder: (context, index) {
            final item = favs[index];
            return CourseCard(
              item: item,
              onTap: () => onItemTap(item),
              onFavouriteToggle: () => onFavouriteToggle(item),
            );
          },
        );
      },
    );
  }
}