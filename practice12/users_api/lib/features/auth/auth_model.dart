import 'package:flutter/cupertino.dart';
import 'package:users_api/core/storage/secure_store.dart';

class AuthModel extends ChangeNotifier {
  AuthModel({required this.storage, String? initToken})
    : _signedIn = initToken != null;

  final SecureStore storage;
  bool _signedIn;

  bool get signedIn => _signedIn;

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    final token = 'tok_${email.hashCode}';
    await storage.saveToken(token);
    _signedIn = true;
    notifyListeners();
  }

  Future<void> logout() {
    _signedIn = false;
    notifyListeners();
    return storage.clear();
  }
}
