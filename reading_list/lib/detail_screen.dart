import 'package:flutter/material.dart';
import 'book.dart';

enum BookAction { toggleRead, delete }

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.book});

  final Book book;

  Future<void> _deletePressed(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete '${book.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;

    if (confirm == true) {
      Navigator.of(context).pop(BookAction.delete);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        // Стрелка назад рисуется автоматически, нет leading и нет BackButton
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('Author: ${book.author}', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Pages: ${book.pages}', style: textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Year: ${book.year ?? 'Year unknown'}', style: textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Status: ${book.read ? "Read" : "Unread"}', style: textTheme.bodyLarge),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(BookAction.toggleRead),
                    child: Text(book.read ? 'Mark as unread' : 'Mark as read'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _deletePressed(context),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}