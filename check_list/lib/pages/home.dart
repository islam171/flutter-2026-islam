import 'package:check_list/pages/settings.dart';
import 'package:check_list/pages/todo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _menuOpen() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: _menuOpen, icon: Icon(Icons.menu_outlined)),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: const Text("Tabs"),
        ),
        body: TabBarView(
          children: [
            const TodoPage(),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
                _navigateSettings(context);
              },
            ),
            const Icon(Icons.directions_bike),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(child: Text("Drawer Text")),
              ListTile(title: const Text("Title 1")),
              ListTile(title: const Text("Title 2")),
            ],
          ),
        ),

      ),
    );
  }

  Future<void> _navigateSettings(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<String>(builder: (context) => const Settings()),
    );

    ScaffoldMessenger.of(context)
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
