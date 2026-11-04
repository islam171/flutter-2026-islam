import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/profile.dart';
import '../data/seed_data.dart';
import '../routes.dart';
import 'favorite_tab.dart';
import 'list_tab.dart';
import 'profile_tab.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _currentTabIndex = 0;
  late List<Item> _items;
  late Profile _profile;

  @override
  void initState() {
    super.initState();
    _items = getSeedItems();
    _profile = Profile.empty();
  }

  void _resetData() {
    setState(() {
      _items = getSeedItems();
      _profile = Profile.empty();
    });
  }

  void _onItemUpdated(Item updated) {
    setState(() {
      final index = _items.indexWhere((i) => i.title == updated.title || i == updated);
      if (index >= 0) {
        _items[index] = updated;
      } else {
        _items.add(updated);
      }
    });
  }

  void _onItemDeleted(Item item) {
    setState(() {
      _items.removeWhere((i) => i.title == item.title);
    });
  }

  Future<void> _openForm([Item? item]) async {
    final result = await Navigator.pushNamed<Item>(context, Routes.form, arguments: item);
    if (!mounted || result == null) return;

    setState(() {
      if (item != null) {
        final index = _items.indexOf(item);
        if (index >= 0) _items[index] = result;
      } else {
        _items.add(result);
      }
    });
  }

  void _openDetail(Item item) {
    Navigator.pushNamed(
      context,
      Routes.detail,
      arguments: DetailScreenArgs(
        item: item,
        profileName: _profile.name,
        onUpdate: _onItemUpdated,
        onDelete: () => _onItemDeleted(item),
        onSwitchTab: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(switch (_currentTabIndex) {
          0 => 'Explore Courses',
          1 => 'Saved Courses',
          _ => 'User Profile',
        }),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
              child: Text('Course Hub', style: Theme.of(context).textTheme.headlineMedium),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('About Course Hub'),
                    content: const Text('Lab 1 App - Course Learning Hub\nBuilt with Flutter (No external packages).'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('Reset Data'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Reset All Data?'),
                    content: const Text('This will restore seed courses and clear your profile.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _resetData();
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          ListTab(
            items: _items,
            onItemTap: _openDetail,
            onFavouriteToggle: (item) {
              _onItemUpdated(item.copyWith(favourite: !item.favourite));
            },
            onAddItem: () => _openForm(),
          ),
          FavouritesTab(
            items: _items,
            onItemTap: _openDetail,
            onFavouriteToggle: (item) {
              _onItemUpdated(item.copyWith(favourite: !item.favourite));
            },
          ),
          ProfileTab(
            profile: _profile,
            items: _items,
            onProfileChanged: (p) => setState(() => _profile = p),
            currentThemeMode: widget.themeMode,
            onThemeModeChanged: widget.onThemeModeChanged,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTabIndex,
        onDestinationSelected: (idx) => setState(() => _currentTabIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Courses'),
          NavigationDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: 'Favourites'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );

  }
}
