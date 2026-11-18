import 'package:flutter/foundation.dart';

import '../../../../core/api/api_exception.dart';
import 'user.dart';
import 'user_repository.dart';

/// Not a State, not a repository: no BuildContext, no mounted, no http.
class UsersModel extends ChangeNotifier {
  UsersModel(this._repo);

  final UserRepository _repo;

  List<User> items = const [];
  ApiException? error;
  bool loading = false;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      items = await _repo.getAll();
    } on ApiException catch (e) {
      error = e;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  /// Returns the error instead of throwing, so the form can show a SnackBar
  /// without the model knowing about the UI. null means success.
  Future<ApiException?> create(User draft) async {
    try {
      final created = await _repo.create(draft);
      items = [created, ...items];
      notifyListeners();
      return null;
    } on ApiException catch (e) {
      return e;
    }
  }
}
