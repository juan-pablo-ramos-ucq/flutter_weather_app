import 'package:flutter/material.dart';
import '../services/shared_preferences.dart';
import 'profile_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSheetContainer extends StatefulWidget {
  const ProfileSheetContainer({super.key});

  @override
  State<ProfileSheetContainer> createState() => _ProfileSheetContainerState();
}

class _ProfileSheetContainerState extends State<ProfileSheetContainer> {
  final PreferencesService _prefsService = PreferencesService();
  final ImagePicker _imagePicker = ImagePicker();

  late final Future<List<String?>> _userData;

  XFile? _cameraImage;
  bool _takingPhoto = false;

  @override
  void initState() {
    super.initState();

    _userData = Future.wait([
      _prefsService.getName(),
      _prefsService.getImgUrl(),
      _prefsService.getEmail(),
    ]);
  }

  Future<void> _takePhoto() async {
    try {
      setState(() => _takingPhoto = true);

      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1200,
      );

      if (photo == null || !mounted) return;

      setState(() {
        _cameraImage = photo;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir la cámara')),
      );
    } finally {
      if (mounted) {
        setState(() => _takingPhoto = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileSheet(
      userData: _userData,
      localImagePath: _cameraImage?.path,
      takingPhoto: _takingPhoto,
      onTakePhoto: _takePhoto,
    );
  }
}
