import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_api/features/auth/auth_model.dart';
import 'package:users_api/features/settings/settings_model.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final prefs = SharedPreferencesAsync();
  String? _selectedValue;
  bool _dark = false;
  final items = ['option1', 'doption2'];

  @override
  void initState() {
    _dark = context.read<SettingsModel>().dark;
    _selectedValue = context.read<SettingsModel>().city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SwitchListTile(
            value: _dark,
            onChanged: (bool value) {
              setState(() {
                _dark = value;
                Provider.of<SettingsModel>(
                  context,
                  listen: false,
                ).setDark(value);
              });
            },
            title: Text("Dark mode"),
          ),
          DropdownButtonFormField(
            value: items.contains(_selectedValue) ? _selectedValue : null,
            items: items
                .map(
                  (option) =>
                      DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
                Provider.of<SettingsModel>(context, listen: false).setCity(value as String);
              });
            },
          ),
          Spacer(),
          ElevatedButton(onPressed: (){
              context.read<AuthModel>().logout();
          }, child: Text("Sign out"))
        ],
      ),
    );
  }
}
