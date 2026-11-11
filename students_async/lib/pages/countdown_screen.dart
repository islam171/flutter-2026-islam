import 'dart:async';

import 'package:flutter/material.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  final int from = 10;
  int _left = 10;
  late StreamSubscription<int> _sub;

  Stream<int> countdown(int from) async* {
    for (var i = from; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint("$i");
      yield i;
    }
  }

  late final Stream<int> _stream = countdown(10);

  @override
  initState() {
    super.initState();
    _sub = countdown(10).listen((i) => setState(() => _left = i));
  }

  @override
  dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("CountDown")),
      body: Center(
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snap) => Column(
            children: [
              Text("${snap.data ?? 10}", style: TextStyle(fontSize: 150)),
              Text("$_left", style: TextStyle(fontSize: 150)),
            ],
          ),
        ),
      ),
    );
  }
}
