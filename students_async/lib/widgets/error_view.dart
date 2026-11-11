import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Could not load students"),
          ElevatedButton(onPressed: () => onRetry(), child: Text("Retry")),
        ],
      ),
    );
  }
}
