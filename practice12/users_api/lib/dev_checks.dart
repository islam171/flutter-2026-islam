// Level 2 + 3 checks. Temporarily call from main() BEFORE runApp:
//   WidgetsFlutterBinding.ensureInitialized();
//   await runChecks(UserRepository(ApiClient.live()));
// (make main async). Delete the call when done.
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'core/api/api_exception.dart';
import 'features/users/user.dart';
import 'features/users/user_repository.dart';

const _user1 = r'''
{
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": { "lat": "-37.3159", "lng": "81.1496" }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}
''';

Future<void> runChecks(UserRepository repo) async {
  final u = User.fromJson(jsonDecode(_user1) as Map<String, dynamic>);
  debugPrint('$u  digits=${u.phoneDigits}');
  debugPrint('round-trip equal: ${User.fromJson(u.toJson()) == u}');

  final all = await repo.getAll();
  debugPrint('${all.length} users: ${all.map((e) => e.name).join(', ')}');

  try {
    await repo.getById(999);
  } on NotFoundException {
    debugPrint('not found');
  }

  final created = await repo.create(
    User(
      id: 0,
      name: 'Test User',
      username: 'tester',
      email: 'test@example.com',
      phone: '',
      website: null,
      address: u.address,
      company: u.company,
    ),
  );
  debugPrint('server assigned id ${created.id}'); // 11
}
