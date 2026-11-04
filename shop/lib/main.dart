import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/books_screen.dart';
import 'package:shop/cart_screen.dart';
import 'package:shop/models/cart.dart';

import 'models/book.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => Cart(), child: const Shell()));
}

class Shell extends StatelessWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    ),
    routes: {
      '/': (_) => BooksScreen(),
      '/cart': (_) => CartScreen(),
    },
    debugShowCheckedModeBanner: false,
  );
}
