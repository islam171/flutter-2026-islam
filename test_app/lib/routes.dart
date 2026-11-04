import 'package:flutter/material.dart';
import 'models/item.dart';
import 'screens/detail_screen.dart';
import 'screens/form_screen.dart';


class Routes {
  static const String detail = '/detail';
  static const String form = '/form';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detail:
        final args = settings.arguments as DetailScreenArgs;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            item: args.item,
            onUpdate: args.onUpdate,
            onDelete: args.onDelete,
            profileName: args.profileName,
            onSwitchTab: args.onSwitchTab,
          ),
        );
      case form:
        final item = settings.arguments as Item?;
        return MaterialPageRoute<Item>(
          builder: (_) => FormScreen(initialItem: item),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Not found')),
          ),
        );
    }
  }
}

class DetailScreenArgs {
  DetailScreenArgs({
    required this.item,
    required this.onUpdate,
    required this.onDelete,
    required this.profileName,
    required this.onSwitchTab,
  });

  final Item item;
  final ValueChanged<Item> onUpdate;
  final VoidCallback onDelete;
  final String profileName;
  final ValueChanged<int> onSwitchTab;
}