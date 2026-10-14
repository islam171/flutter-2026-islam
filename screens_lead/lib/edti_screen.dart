import 'package:flutter/material.dart';

import 'students.dart';

class EditScreen extends StatefulWidget {
  final Student student;

  const EditScreen({super.key, required this.student});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late String _name = widget.student.name;

  bool get _dirty => _name != widget.student.name;

  Future<void> _confirmDiscard() async {
    final discard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Discard changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    if (discard == true && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: ((didPop, _) async {
        if (didPop) return;
        await _confirmDiscard();
      }),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Student Name')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => _name = v),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(_name),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
