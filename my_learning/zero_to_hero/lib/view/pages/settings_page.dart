import 'package:flutter/material.dart';
import 'package:zero_to_hero/view/pages/flexible_expended_page.dart';
import 'package:zero_to_hero/view/pages/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double slider_value = 0.0;
  String? menuItem = 'e1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Snackbar"),
                      duration: Duration(seconds: 5),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text("Open snack bar"),
              ),
              Container(height: 50.0, child: VerticalDivider()),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Alert dialog"),
                        content: Text("Alert content"),
                        actions: [
                          FilledButton(onPressed: () {}, child: Text("OK")),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text("Open Alert dialog"),
              ),
              Divider(color: Colors.teal, thickness: 5.0),
              DropdownButton(
                value: menuItem,
                items: [
                  DropdownMenuItem(child: Text("Element 1"), value: "e1"),
                  DropdownMenuItem(child: Text("Element 2"), value: "e2"),
                  DropdownMenuItem(child: Text("Element 3"), value: "e3"),
                ],
                onChanged: (String? value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FlexibleExpendedPage();
                      },
                    ),
                  );
                },
                child: Text("Show Flexible and Expanded"),
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Text(controller.text),
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) => setState(() {
                  isChecked = value;
                }),
              ),
              CheckboxListTile(
                title: Text("Open snack bar"),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text("Click me"),
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              Slider.adaptive(
                value: slider_value,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    slider_value = value;
                  });
                  print(value);
                },
              ),
              InkWell(
                child: Image.asset('assets/1.jpg'),
                onTap: () {
                  print("hello");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
