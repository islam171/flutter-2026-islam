import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/countdown.dart';
import '../routes.dart';
import '../utils/format.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.item,
    required this.onUpdate,
    required this.onDelete,
    required this.profileName,
    required this.onSwitchTab,
  });

  final Item item;
  final ValueChanged<Item> onUpdate;
  final VoidCallback onDelete;
  final String profileName;
  final ValueChanged<int> onSwitchTab;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Timer? _timer;
  late Item _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.item;
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handlePrimaryAction() async {
    final isEnrolled = _currentItem.contains(widget.profileName);

    if (widget.profileName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please set your profile name before enrolling.'),
          action: SnackBarAction(
            label: 'Profile',
            onPressed: () {
              Navigator.pop(context);
              widget.onSwitchTab(2);
            },
          ),
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEnrolled ? 'Leave Course?' : 'Enroll in Course?'),
        content: Text(isEnrolled
            ? 'Are you sure you want to unenroll from ${_currentItem.title}?'
            : 'Confirm registration for ${_currentItem.title}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Confirm')),
        ],
      ),
    );

    if (!mounted || confirm != true) return;

    final updatedNames = List<String>.from(_currentItem.names);
    if (isEnrolled) {
      updatedNames.remove(widget.profileName);
    } else {
      updatedNames.add(widget.profileName);
    }

    final updatedItem = _currentItem.copyWith(names: updatedNames);
    setState(() => _currentItem = updatedItem);
    widget.onUpdate(updatedItem);
  }

  @override
  Widget build(BuildContext context) {
    final countdown = calculateCountdown(_currentItem.when);
    final isEnrolled = _currentItem.contains(widget.profileName);

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentItem.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          PopupMenuButton<String>(
            onSelected: (val) async {
              if (val == 'edit') {
                final result = await Navigator.pushNamed<Item>(
                  context,
                  Routes.form,
                  arguments: _currentItem,
                );
                if (mounted && result != null) {
                  setState(() => _currentItem = result);
                  widget.onUpdate(result);
                }
              } else if (val == 'delete') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Course?'),
                    content: const Text('This action cannot be undone.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
                    ],
                  ),
                );
                if (mounted && confirm == true) {
                  widget.onDelete();
                  Navigator.pop(context);
                }
              }
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(_currentItem.category.icon, size: 64, color: Theme.of(context).colorScheme.primary),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Chip(
                  avatar: Icon(_currentItem.category.icon, size: 16),
                  label: Text(_currentItem.category.label),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    switch (countdown) {
                      Upcoming(:final remaining) => 'Starts in ${AppFormat.duration(remaining)}',
                      Started(:final elapsed) => 'Started ${AppFormat.duration(elapsed)} ago',
                      Ended() => 'Course Ended',
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      const Tab(text: 'About'),
                      Tab(text: 'Enrolled (${_currentItem.count})'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // About Tab
                        ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            ListTile(
                              leading: const Icon(Icons.event),
                              title: const Text('Date & Time'),
                              subtitle: Text(AppFormat.date(_currentItem.when)),
                            ),
                            ListTile(
                              leading: Icon(_currentItem.mode ? Icons.link : Icons.place),
                              title: Text(_currentItem.mode ? 'Online Link' : 'Venue Location'),
                              subtitle: Text(_currentItem.optionalText ?? 'No location provided'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.people),
                              title: const Text('Capacity Status'),
                              subtitle: Text('${_currentItem.places.taken} enrolled / ${_currentItem.places.free} seats remaining'),
                            ),
                            if (_currentItem.optionalText != null) ...[
                              const Divider(),
                              Text('Description', style: Theme.of(context).textTheme.titleSmall),
                              const SizedBox(height: 4),
                              Text(_currentItem.optionalText!),
                            ],
                          ],
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _currentItem.names.length,
                          itemBuilder: (ctx, idx) {
                            final name = _currentItem.names[idx];
                            final isUser = name == widget.profileName;
                            return ListTile(
                              leading: CircleAvatar(child: Text('${idx + 1}')),
                              title: Text(
                                name,
                                style: TextStyle(
                                  fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
                                  color: isUser ? Theme.of(context).colorScheme.primary : null,
                                ),
                              ),
                              trailing: isUser ? const Chip(label: Text('You')) : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: (_currentItem.isFull && !isEnrolled) ? null : _handlePrimaryAction,
                child: Text(isEnrolled ? 'Leave Course' : 'Enroll Now'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}