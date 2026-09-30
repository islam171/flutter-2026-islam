import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchCard extends StatefulWidget {
  const StopWatchCard({super.key});

  @override
  State<StopWatchCard> createState() => _StopWatchCardState();
}

class _StopWatchCardState extends State<StopWatchCard> {
  int _seconds = 0;
  Timer? _timer;

  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stop() {
    _timer?.cancel();
  }

  void _reset() {
    setState(() {
      _seconds = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(10.0) ,child: Center(child: Text(_seconds.toString()))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _start, child: Text("Start")),
              ElevatedButton(onPressed: _stop, child: Text("Stop")),
              ElevatedButton(onPressed: _reset, child: Text("Reset")),
            ],
          ),
        ],
      );
  }
}
