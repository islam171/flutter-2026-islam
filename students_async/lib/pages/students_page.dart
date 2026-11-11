import 'package:flutter/material.dart';

import '../fake_api.dart';
import '../widgets/empty_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_view.dart';
import '../widgets/student_list.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<Student>? _students;

  Object? _error;
  bool _saving = false;
  final _api = FakeApi(empty: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _students = null;
      _error = null;
    });
    try {
      final list = await _api.fetchStudents();
      if (!mounted) return;
      setState(() {
        _students = list;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _error != null
            ? ErrorView(onRetry: _load)
            : _students == null
            ? LoadingView()
            : _students!.isEmpty
            ? EmptyView()
            : Column(
                children: [
                  ElevatedButton(onPressed: _load, child: Text("Hello")),
                  Expanded(
                    child: StudentList(
                      students: _students ?? [],
                      compact: false,
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saving || _students == null || _error != null
            ? null
            : () async {
                if (_saving || _students == null) return;
                setState(() {
                  _saving = true;
                });
                try {
                  await _api.save(_students!.length);
                  if (!context.mounted) return;
                  Navigator.pop(context);
                } on StateError catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.message.toString())));
                } finally {
                  if (context.mounted) {
                    setState(() {
                      _saving = false;
                    });
                  }
                }
              },
        child: !_saving
            ? Icon(Icons.save)
            : const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
