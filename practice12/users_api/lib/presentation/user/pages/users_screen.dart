import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/api_exception.dart';
import 'new_user_screen.dart';
import '../../../features/users/status_views.dart';
import '../../../features/users/user.dart';
import 'user_detail_screen.dart';
import '../../../features/users/users_model.dart';

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
    if (m.loading && m.items.isEmpty) return const LoadingView();

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
    final m = context.watch<UsersModel>();
    return Column(
      children: [
        if (m.fromCache)
          MaterialBanner(
            content: const Text(
              'Saved data · No connection',
            ),
            leading: const Icon(Icons.cloud_off),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<UsersModel>().load();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        Expanded(
          child: ListView.separated(
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
          ),
        ),
      ],
    );
  }
}
