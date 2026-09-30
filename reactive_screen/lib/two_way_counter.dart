import 'package:flutter/material.dart';
import 'package:reactive_screen/counter.dart';

class TwoWayCounter extends StatefulWidget {
  const TwoWayCounter({super.key});

  @override
  State<TwoWayCounter> createState() => _TwoWayCounterState();
}

class _TwoWayCounterState extends State<TwoWayCounter> {
  int _taps = 0;
  bool _saving = false;

  void _decrement(){
    setState(() {
      _taps--;
    });
  }

  void _increment(){
    setState(() {
      _taps++;
    });
  }

  Future<void> _save() async {
    if (_saving) {
      return;
    }
    setState(() {
      _saving = true;
    });
    await Future.delayed(Duration(seconds: 2), () => {});
    if (!mounted) {
      return;
    }
    setState(() {
      _saving = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Saved"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Counter(taps: _taps, increment: _increment, decrement: _decrement),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving ? CircularProgressIndicator() : Text("Save"),
        ),
      ],
    );
  }
}
