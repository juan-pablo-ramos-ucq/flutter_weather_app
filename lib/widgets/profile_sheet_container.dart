import 'package:flutter/material.dart';
import '../services/shared_preferences.dart';
import 'profile_sheet.dart';

class ProfileSheetContainer extends StatefulWidget {
  const ProfileSheetContainer({super.key});

  @override
  State<ProfileSheetContainer> createState() => _ProfileSheetContainerState();
}

class _ProfileSheetContainerState extends State<ProfileSheetContainer> {
  final PreferencesService _prefsService = PreferencesService();

  late final Future<List<String?>> _userData;

  @override
  void initState() {
    super.initState();

    _userData = Future.wait([
      _prefsService.getName(),
      _prefsService.getImgUrl(),
      _prefsService.getEmail(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ProfileSheet(userData: _userData);
  }
}
