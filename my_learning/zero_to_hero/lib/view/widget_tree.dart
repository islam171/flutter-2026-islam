import 'package:flutter/material.dart';
import 'package:zero_to_hero/data/FavoriteModel.dart';
import 'package:zero_to_hero/data/notifiers.dart';
import 'package:zero_to_hero/view/pages/home_page.dart';
import 'package:zero_to_hero/view/pages/profile_page.dart';
import 'package:zero_to_hero/view/pages/settings_page.dart';
import 'package:zero_to_hero/widgets/navbar.dart';
import 'package:provider/provider.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("App"),
          actions: [
            IconButton(
              onPressed: () {
                isDarkModeNotifier.value = !isDarkModeNotifier.value;
              },
              icon: ValueListenableBuilder(
                valueListenable: isDarkModeNotifier,
                builder: (context, isDarkMode, child) {
                  return Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode);
                },
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage(title: "Settings");
                    },
                  ),
                );
              },
              icon: Icon(Icons.settings),
            ),
            Consumer<FavoriteModel>(
              builder: (context, value, child) {
                return Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart),
                    ),
                    Positioned(
                      top: 3,
                      right: 3,
                      child: Text("${value.totalFavorites}", style: TextStyle(color: Colors.teal)),
                    ),
                  ],
                );
              },
            ),
            IconButton(
              onPressed: () {
                final a = Provider.of<FavoriteModel>(context, listen: false);
                a.removeAll();
              },
              icon: Icon(Icons.clear),
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (context, selectedPage, child) {
            return pages.elementAt(selectedPage);
          },
        ),
        bottomNavigationBar: Navbar(),
      ),
    );
  }
}
