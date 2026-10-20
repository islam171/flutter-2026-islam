import 'package:flutter/material.dart';
import '/book.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    required this.onToggle,
  });

  final Book book;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Первая буква названия для аватара
    final firstLetter = book.title.isNotEmpty ? book.title[0] : '?';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Слева Stack с аватаром и точкой непрочитанной книги
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  child: Text(firstLetter),
                ),
                if (!book.read)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Растянутая колонка с текстом
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${book.author} · ${book.pages} pp.',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            // Справа чекбокс
            Checkbox(
              value: book.read,
              onChanged: (_) => onToggle(),
            ),
          ],
        ),
      ),
    );
  }
}