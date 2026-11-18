import 'package:flutter/material.dart';

import 'user.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen(this.user, {super.key});
  final User user;

  @override
  Widget build(BuildContext context) {
    final a = user.address;
    final website = user.website;
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ListView(
        children: [
          _Row('Username', user.username),
          _Row('Email', user.email),
          // Practice 12 wires these to url_launcher.
          _Row('Phone', user.phone, onTap: () {}),
          _Row('Website', website ?? 'none', onTap: website == null ? null : () {}),
          const Divider(),
          _Row('Street', '${a.street}, ${a.suite}'),
          _Row('City', '${a.city} ${a.zipcode}'),
          _Row('Geo', '${a.geo.lat}, ${a.geo.lng}'),
          const Divider(),
          _Row('Company', user.company.name),
          _Row('Catch phrase', user.company.catchPhrase),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value, {this.onTap});
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(value),
        subtitle: Text(label),
        onTap: onTap,
      );
}
