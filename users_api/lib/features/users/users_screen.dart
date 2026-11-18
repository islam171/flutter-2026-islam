import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/api/api_exception.dart';
import 'new_user_screen.dart';
import 'status_views.dart';
import 'user.dart';
import 'user_detail_screen.dart';
import 'users_model.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final m = context.watch<UsersModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const NewUserScreen()),
        ),
        child: const Icon(Icons.person_add),
      ),
      body: _body(m),
    );
  }

  Widget _body(UsersModel m) {
    // Full-screen spinner only for the first load; during pull-to-refresh
    // the RefreshIndicator shows progress over the existing list.
    if (m.loading && m.items.isEmpty) return const LoadingView();

    // Exhaustive because ApiException is sealed. No default.
    final content = switch (m.error) {
      null => UserList(m.items),
      NoConnectionException() => Offline(onRetry: m.load),
      NotFoundException() || UnauthorizedException() => const NotAllowed(),
      ServerException(:final status) => ServerError(status, onRetry: m.load),
      BadResponseException(:final detail) => GenericError(detail: detail),
    };
    return RefreshIndicator(onRefresh: m.load, child: content);
  }
}

class UserList extends StatelessWidget {
  const UserList(this.users, {super.key});
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final u = users[i];
        return ListTile(
          title: Text(u.name),
          subtitle: Text('${u.email}\n${u.address.city}'),
          isThreeLine: true,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => UserDetailScreen(u)),
          ),
        );
      },
    );
  }
}
