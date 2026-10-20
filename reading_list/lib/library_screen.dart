import 'package:flutter/material.dart';
import 'book.dart';
import 'book_tile.dart';
import 'detail_screen.dart';
import 'add_book_screen.dart';

// Исходный сид-список из задания
final seed = <Book>[
  Book(title: 'Widgets All the Way Down', author: 'A. Nurmagambetova', pages: 288, year: 2021, read: true),
  Book(title: 'Null Safety for Humans', author: 'B. Seitkali', pages: 196, year: 2022),
  Book(title: 'Constraints Go Down, Sizes Go Up', author: 'C. Tashimova', pages: 320),
  Book(title: 'The Navigator Is a Stack', author: 'D. Alibekov', pages: 240, year: 2020),
  Book(title: 'A Very Long Title About Forms, Focus, the Keyboard and Everything That Overflows', author: 'E. Omarova', pages: 176, year: 2023),
];

enum Filter { all, unread, read }

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<Book> _books = [...seed];
  Filter _filter = Filter.all;

  // Геттер с использованием switch expression
  List<Book> get _visible {
    return switch (_filter) {
      Filter.all => _books,
      Filter.unread => unread(_books),
      Filter.read => _books.where((b) => b.read).toList(),
    };
  }

  void _openAddBook() async {
    final newBook = await Navigator.of(context).push<Book>(
      MaterialPageRoute(builder: (_) => const AddBookScreen()),
    );
    if (!mounted) return;
    if (newBook != null) {
      setState(() {
        _books.add(newBook);
      });
    }
  }

  void _openDetail(Book book) async {
    final action = await Navigator.of(context).push<BookAction>(
      MaterialPageRoute(builder: (_) => DetailScreen(book: book)),
    );
    if (!mounted) return;

    if (action != null) {
      setState(() {
        switch (action) {
          case BookAction.toggleRead:
            book.read = !book.read;
            break;
          case BookAction.delete:
            _books.remove(book);
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reading list (${_visible.length})'),
      ),
      body: Column(
        children: [
          // Шапка со статистикой (Level 3)
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('${_books.length}', style: textTheme.headlineSmall),
                        Text('Books', style: textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('${totalPages(_books)}', style: textTheme.headlineSmall),
                        Text('Pages', style: textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('${unread(_books).length}', style: textTheme.headlineSmall),
                        Text('Unread', style: textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Выбор фильтров ChoiceChips (Level 2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: _filter == Filter.all,
                  onSelected: (selected) => setState(() => _filter = Filter.all),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Unread'),
                  selected: _filter == Filter.unread,
                  onSelected: (selected) => setState(() => _filter = Filter.unread),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Read'),
                  selected: _filter == Filter.read,
                  onSelected: (selected) => setState(() => _filter = Filter.read),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Список элементов через ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: _visible.length,
              itemBuilder: (context, index) {
                final book = _visible[index];
                return InkWell(
                  onTap: () => _openDetail(book),
                  child: BookTile(
                    book: book,
                    onToggle: () {
                      setState(() {
                        book.read = !book.read;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddBook,
        child: const Icon(Icons.add),
      ),
    );
  }
}