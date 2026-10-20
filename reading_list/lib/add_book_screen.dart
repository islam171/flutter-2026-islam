import 'package:flutter/material.dart';
import 'book.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final author = _authorController.text.trim();
      final pages = int.parse(_pagesController.text.trim());
      final year = int.tryParse(_yearController.text.trim());

      final newBook = Book(
        title: title,
        author: author,
        pages: pages,
        year: year,
      );

      Navigator.of(context).pop(newBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) {
                  if (v == null || v.trim().length < 2) {
                    return 'Title must be at least 2 characters';
                  }
                  return null;
                },
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _authorController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Author cannot be empty';
                  }
                  return null;
                },
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pagesController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Pages'),
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n <= 0) {
                    return 'A whole number above 0';
                  }
                  return null;
                },
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Year (optional)'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final y = int.tryParse(v.trim());
                  final currentYear = DateTime.now().year;
                  if (y == null || y < 1450 || y > currentYear) {
                    return 'Enter a valid year between 1450 and $currentYear';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _save(),
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Save Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}