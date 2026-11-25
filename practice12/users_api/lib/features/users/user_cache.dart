import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:users_api/features/users/user.dart';

class UserCache {
  Future<File> get _cacheUsers async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/users.json');
  }

  save(List<User> list) async {
    final f = await _cacheUsers;
    await f.writeAsString(jsonEncode([for (final u in list) u.toJson()]));
  }

  Future<List<User>?> load() async {
    final f = await _cacheUsers;
    if (!await f.exists()) return null;
    final raw = jsonDecode(await f.readAsString()) as List<dynamic>;
    return [for (final e in raw) User.fromJson(e as Map<String, dynamic>)];
  }
}
