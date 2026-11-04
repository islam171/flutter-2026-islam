import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart_badge.dart';

import 'models/book.dart';
import 'models/cart.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [CartBadge()]),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final b = books[index];
          final isAdded = context.watch<Cart>().items.contains(b);

          return ListTile(
            title: Text(b.title),
            subtitle: Text(b.author),
            trailing: isAdded
                ? Text('Added')
                : OutlinedButton(
                    onPressed: () {
                      final ok = context.read<Cart>().add(b);
                      if (ok) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Added")));
                      }
                    },
                    child: Text("Add"),
                  ),
          );
        },
      ),
    );
  }
}
