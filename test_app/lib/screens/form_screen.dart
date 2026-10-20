import 'package:flutter/material.dart';
import '../models/item.dart';
import '../utils/format.dart';

// Form Screen — New and Edit
class FormScreen extends StatefulWidget {
  const FormScreen({super.key, this.initialItem});

  final Item? initialItem;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _limitController;
  late final TextEditingController _locationController;
  late final TextEditingController _descController;

  late final FocusNode _titleFocus;
  late final FocusNode _limitFocus;
  late final FocusNode _locationFocus;
  late final FocusNode _descFocus;

  late CourseCategory _category;
  late DateTime _when;
  late bool _mode;
  late bool _isSaving;

  @override
  void initState() {
    super.initState();
    final item = widget.initialItem ?? Item.empty();

    _titleController = TextEditingController(text: item.title);
    _limitController = TextEditingController(text: item.limit.toString());
    _locationController = TextEditingController(text: item.optionalText ?? '');
    _descController = TextEditingController(text: item.optionalText ?? '');

    _titleFocus = FocusNode();
    _limitFocus = FocusNode();
    _locationFocus = FocusNode();
    _descFocus = FocusNode();

    _category = item.category;
    _when = item.when;
    _mode = item.mode;
    _isSaving = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _limitController.dispose();
    _locationController.dispose();
    _descController.dispose();

    _titleFocus.dispose();
    _limitFocus.dispose();
    _locationFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  // R30: Check form dirty state for PopScope
  bool get _isDirty {
    final orig = widget.initialItem ?? Item.empty();
    return _titleController.text != orig.title ||
        _limitController.text != orig.limit.toString() ||
        _category != orig.category ||
        _mode != orig.mode;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _when,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_when),
      );
      if (time != null && mounted) {
        setState(() {
          _when = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
        });
      }
    }
  }

  Future<void> _save() async {
    if (_isSaving) return; // Prevent double tap

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSaving = true);

      // R17: Simulate 1-second save
      await Future.delayed(const Duration(seconds: 1));

      // R14: Check mounted after await before pop
      if (!mounted) return;

      final result = Item(
        title: _titleController.text.trim(),
        category: _category,
        when: _when,
        limit: int.parse(_limitController.text.trim()),
        names: widget.initialItem?.names ?? const [],
        mode: _mode,
        optionalText: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
        favourite: widget.initialItem?.favourite ?? false,
      );

      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // R30: PopScope handles back gestures
    return PopScope(
      canPop: !_isDirty || _isSaving,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Discard Changes?'),
            content: const Text('You have unsaved changes. Are you sure you want to leave?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep Editing')),
              TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Discard')),
            ],
          ),
        );
        if (confirm == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.initialItem == null ? 'New Course' : 'Edit Course'),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // R35: Dismiss keyboard
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  // R34: Title validator 3-60 chars
                  TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocus,
                    maxLength: 60,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Course Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().length < 3 || v.trim().length > 60) {
                        return 'Title must be between 3 and 60 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  // Category Dropdown
                  DropdownButtonFormField<CourseCategory>(
                    value: _category,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: CourseCategory.values.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Row(
                          children: [
                            Icon(c.icon, size: 20),
                            const SizedBox(width: 8),
                            Text(c.label),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _category = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  // R34: Limit validator
                  TextFormField(
                    controller: _limitController,
                    focusNode: _limitFocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Capacity Limit',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final val = int.tryParse(v ?? '');
                      if (val == null || val < 1 || val > 500) {
                        return 'Limit must be 1–500';
                      }
                      final currentCount = widget.initialItem?.count ?? 0;
                      if (val < currentCount) {
                        return 'Cannot be below current participants ($currentCount)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  // Mode switch
                  SwitchListTile(
                    title: const Text('Online Mode (URL link)'),
                    value: _mode,
                    onChanged: (v) => setState(() => _mode = v),
                  ),
                  const SizedBox(height: 12),
                  // R34: Location / Link with mode validation
                  TextFormField(
                    controller: _locationController,
                    focusNode: _locationFocus,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: _mode ? 'Meeting URL (must contain ://)' : 'Physical Venue',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Location/URL is required';
                      if (_mode && !v.contains('://')) {
                        return 'Online URL must contain "://" (e.g. https://...)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  // R36: Date and Time field readOnly
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(text: AppFormat.date(_when)),
                    decoration: const InputDecoration(
                      labelText: 'Start Date & Time',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 12),
                  // Optional Description
                  TextFormField(
                    controller: _descController,
                    focusNode: _descFocus,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Optional Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // R17: Save button with progress indicator
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _save,
                      child: _isSaving
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Save Course'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}