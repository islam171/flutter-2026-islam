import 'package:flutter/material.dart';

class TapCard extends StatefulWidget {
  const TapCard({super.key});

  @override
  _TapCardState createState() => _TapCardState();
}

class _TapCardState extends State<TapCard> {
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            _taps++;
          });
        },
        onLongPress: _onLongPress,
        child: ListTile(title: Text("Tap this Card $_taps")),
      ),
    );
  }

  Future<void> _onLongPress() async {
    final reset = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("Reset the count?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Reset"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel"),
          ),
        ],
      ),
    );

    if (reset == true) {
      setState(() {
        _taps = 0;
      });
    }
  }
}
