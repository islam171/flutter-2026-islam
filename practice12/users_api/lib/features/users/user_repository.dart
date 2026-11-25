import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:users_api/features/users/user_cache.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_exception.dart';
import 'user.dart';

class UsersResult {
  final List<User> items;
  final bool fromCache;

  UsersResult({required this.items, required this.fromCache});
}

class UserRepository {
  UserRepository(this._api, {required this.userCache});

  final ApiClient _api;
  final UserCache userCache;

  Future<List<User>> fetchUsers() async {
    final http.Response r = await _api.get(Uri.https(_api.host, '/users'));
    return _parse('users', () {
      final list = _api.decode(r) as List<dynamic>;
      return list.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    });
  }

  Future<UsersResult> getAll() async {
    try {
      final fresh = await fetchUsers();
      await userCache.save(fresh);
      return UsersResult(items: fresh, fromCache: false);
    } on NoConnectionException catch (e) {
      final saved = await userCache.load();
      if (saved == null) rethrow;
      return UsersResult(items: saved, fromCache: true);
    }
  }

  Future<User> getById(int id) async {
    final r = await _api.get(Uri.https(_api.host, '/users/$id'));
    return _parse(
      'users/$id',
      () => User.fromJson(_api.decode(r) as Map<String, dynamic>),
    );
  }

  Future<User> create(User draft) async {
    final r = await _api.post(
      Uri.https(_api.host, '/users'),
      body: jsonEncode(draft.toJson()),
    );
    if (r.statusCode != 201) {
      throw BadResponseException('users: expected 201, got ${r.statusCode}');
    }
    return _parse(
      'users (create)',
      () => User.fromJson(_api.decode(r) as Map<String, dynamic>),
    );
  }

  T _parse<T>(String where, T Function() build) {
    try {
      return build();
    } on TypeError catch (e) {
      throw BadResponseException('$where: $e');
    } on FormatException catch (e) {
      throw BadResponseException('$where: $e');
    }
  }
}
