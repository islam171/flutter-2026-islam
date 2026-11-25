import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  static const snackBar = SnackBar(content: Text('permission denied'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blue.shade100,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : null,
              child: _profileImage == null
                  ? const Text(
                      "I",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),

            _profileImage != null
                ? Image.file(_profileImage!, height: 250)
                : const Text('No image selected.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => choosePhoto(),
              child: const Text('Choose photo'),
            ),
            ElevatedButton(
              onPressed: () => _takePhoto(),
              child: const Text('Take a Photo'),
            ),
          ],
        ),
      ),
    );
  }

  void _takePhoto() async {
    final status = await Permission.camera.request();

    switch (status) {
      case PermissionStatus.granted:
        await pickFromCamera();
        break;

      case PermissionStatus.denied:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Camera permission is required")),
        );
        break;

      case PermissionStatus.permanentlyDenied:
        await showCameraSettingsDialog();
        break;

      case PermissionStatus.restricted:
        // showCameraRestrictedMessage();
        break;

      default:
        break;
    }
  }

  Future<void> showCameraSettingsDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Camera permission denied"),
        content: const Text("Please enable camera access in app settins."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: const Text("Open settings"),
          ),
        ],
      ),
    );
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1025,
      imageQuality: 90,
    );

    if (image == null) return;

    if (!mounted) return;

    setState(() {});
  }

  Future<String> saveAvatar(XFile image) async {
    final directory = await getApplicationCacheDirectory();

    final savedImage = await File(image.path)
        .copy('${directory.path}/avatar.jpg');

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('avatarPath', savedImage.path);

    return savedImage.path;
  }

  Future<void> choosePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      imageQuality: 80,
    );

    if (image == null) return;

    if (!mounted) return;
    setState(() {});
  }
}
