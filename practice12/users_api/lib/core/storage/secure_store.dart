import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    try{
      await storage.write(key: "token", value: token);
    }catch(e){
      print("Error saving token: $e");
    }
  }

  Future<String?> readToken() async {
    try {
      String? token = await storage.read(key: 'token');
      return token;
    } catch (e) {
      print('Error reading token: $e');
      return null;
    }
  }

  Future<void> clear() async {
    try {
      await storage.delete(key: 'token');
      print('Token deleted successfully');
    } catch (e) {
      print('Error deleting token: $e');
    }
  }
}
