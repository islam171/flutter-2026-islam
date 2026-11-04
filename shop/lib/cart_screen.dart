import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'models/book.dart';
import 'models/cart.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cart"),
        actions: [
          IconButton(
            onPressed: () async {
              final confirmed = await showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text("Clear cart"),
                    content: const Text(
                      "Are you sure want to remove all books",
                    ),
                    actions: [
                      TextButton(
                        child: Text("Clear"),
                        onPressed: () {
                          Navigator.pop(dialogContext, false);
                        },
                      ),
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(dialogContext, true);
                        },
                      ),
                    ],
                  );
                },
              );
              if(!context.mounted) return;
              if(confirmed){
                context.read<Cart>().clear();
              }
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<Cart>(
              builder: (context, cart, _) => ListView.builder(
                itemCount: cart.count,
                itemBuilder: (context, index) {
                  Book a = cart.items[index];
                  return ListTile(
                    title: Text(a.title),
                    subtitle: Text('${a.price} * ${cart.qtyOf(a)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => cart.increment(a),
                          icon: Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () => cart.remove(a),
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
              child: Text("total"),
            ),
          ),
          Consumer<Cart>(
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 8),
                Text("Total: "),
              ],
            ),
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    child!,
                    const SizedBox(width: 8),
                    Text("${cart.total} tg"),
                  ],
                ),
              );
            },
          ),
          Consumer<Cart>(
            builder: (context, cart, child) {
              return ElevatedButton(
                onPressed: () {},
                child: Text("Clear cart"),
              );
            },
          ),
        ],
      ),
    );
  }
}
