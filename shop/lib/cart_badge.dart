import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});


  @override
  Widget build(BuildContext context) {
    final n = context.select<Cart, int>((c) => c.count);
    return Badge(
      label: Text('$n'),
      child: IconButton(onPressed: () {
        Navigator.of(context).pushNamed('/cart');
      }, icon: Icon(Icons.shopping_cart)),
    );
  }
}
