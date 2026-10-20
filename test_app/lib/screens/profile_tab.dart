import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/profile.dart';

// Tab 3 — Profile & Theme
class ProfileTab extends StatefulWidget {
  const ProfileTab({
    super.key,
    required this.profile,
    required this.items,
    required this.onProfileChanged,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  final Profile profile;
  final List<Item> items;
  final ValueChanged<Profile> onProfileChanged;
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late final TextEditingController _nameController;
  late final TextEditingController _groupController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _groupController = TextEditingController(text: widget.profile.group);
  }

  @override
  void didUpdateWidget(covariant ProfileTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile != widget.profile) {
      _nameController.text = widget.profile.name;
      _groupController.text = widget.profile.group;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _groupController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onProfileChanged(
        widget.profile.copyWith(
          name: _nameController.text.trim(),
          group: _groupController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // R38: Compute "You are on N lists" dynamically
    final enrolledCount = widget.items.where((i) => i.contains(widget.profile.name)).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(
                        widget.profile.name.isNotEmpty ? widget.profile.name[0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.profile.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text('Group: ${widget.profile.group}'),
                          const SizedBox(height: 4),
                          Text(
                            'You are enrolled in $enrolledCount courses',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Profile Settings', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            // R38: Name controller onSubmitted
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'Name required' : null,
              onFieldSubmitted: (_) => _saveProfile(),
            ),
            const SizedBox(height: 12),
            // R38: Group validator with RegExp
            TextFormField(
              controller: _groupController,
              decoration: const InputDecoration(
                labelText: 'Group (e.g. CS-201)',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Group required';
                final reg = RegExp(r'^[A-Z]{2,4}-\d{3}$');
                if (!reg.hasMatch(v.trim())) return 'Format must be like CS-201';
                return null;
              },
              onFieldSubmitted: (_) => _saveProfile(),
            ),
            const SizedBox(height: 24),
            // R22: Theme choice chips
            Text('Theme Mode', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('System'),
                  selected: widget.currentThemeMode == ThemeMode.system,
                  onSelected: (_) => widget.onThemeModeChanged(ThemeMode.system),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Light'),
                  selected: widget.currentThemeMode == ThemeMode.light,
                  onSelected: (_) => widget.onThemeModeChanged(ThemeMode.light),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Dark'),
                  selected: widget.currentThemeMode == ThemeMode.dark,
                  onSelected: (_) => widget.onThemeModeChanged(ThemeMode.dark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}