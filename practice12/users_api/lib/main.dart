import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:users_api/core/storage/secure_store.dart';
import 'package:users_api/features/auth/auth_model.dart';
import 'package:users_api/features/settings/settings_model.dart';
import 'package:users_api/features/users/user_cache.dart';
import 'package:users_api/presentation/auth/pages/login_page.dart';
import 'package:users_api/presentation/home/pages/home_page.dart';

import 'core/api/api_client.dart';
import 'features/users/user_repository.dart';
import 'features/users/users_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = SharedPreferencesAsync();
  final dark = await prefs.getBool('darkMode') ?? false;
  final city = await prefs.getString("cityFilter") ?? "";
  final storage = SecureStore();
  final api = ApiClient(http.Client(), storage: storage);

  final token = await storage.readToken();
  // final authModel = AuthModel(storage: storage);
  // await authModel.login("islamkabdne@gmail.com", "helloislam");

  final cache = UserCache();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsModel(prefs, city: city, dark: dark),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              UsersModel(UserRepository(api, userCache: cache))..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthModel(storage: storage, initToken: token),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Users API',
    themeMode: context.watch<SettingsModel>().dark
        ? ThemeMode.dark
        : ThemeMode.light,
    darkTheme: ThemeData(colorScheme: ColorScheme.dark()),
    home: context.watch<AuthModel>().signedIn ? const HomePage() : LoginPage(),
  );
}
