import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/course_card.dart';
import '../widgets/empty_state.dart';

class ListTab extends StatefulWidget {
  const ListTab({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.onFavouriteToggle,
    required this.onAddItem,
  });

  final List<Item> items;
  final ValueChanged<Item> onItemTap;
  final ValueChanged<Item> onFavouriteToggle;
  final VoidCallback onAddItem;

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  final TextEditingController _searchController = TextEditingController();
  CourseCategory? _selectedCategory;
  bool _showPastOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Item> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    return widget.items.where((item) {
      final matchesSearch = query.isEmpty || item.title.toLowerCase().contains(query);
      final matchesCategory = _selectedCategory == null || item.category == _selectedCategory;
      final matchesPast = !_showPastOnly || item.isPast;
      return matchesSearch && matchesCategory && matchesPast;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                isDense: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: _selectedCategory == null,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedCategory = null);
                  },
                ),
                const SizedBox(width: 8),
                ...CourseCategory.values.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat.label),
                      avatar: Icon(cat.icon, size: 18),
                      selected: _selectedCategory == cat,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? cat : null;
                        });
                      },
                    ),
                  );
                }),
                FilterChip(
                  label: const Text('Past'),
                  selected: _showPastOnly,
                  onSelected: (val) {
                    setState(() => _showPastOnly = val);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: filtered.isEmpty
                ? EmptyStateWidget(
              icon: Icons.search_off,
              message: 'No courses found matching your criteria.',
              buttonLabel: 'Clear filters',
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _selectedCategory = null;
                  _showPastOnly = false;
                });
              },
            )
                : LayoutBuilder(
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
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return CourseCard(
                        item: item,
                        onTap: () => widget.onItemTap(item),
                        onFavouriteToggle: () => widget.onFavouriteToggle(item),
                      );
                    },
                  );
                }
                return ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 0),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return CourseCard(
                      item: item,
                      onTap: () => widget.onItemTap(item),
                      onFavouriteToggle: () => widget.onFavouriteToggle(item),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}