import 'package:flutter/material.dart';
import 'avatar.dart';
import 'logo.dart';
import 'profile_sheet_method.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(child: Logo()),
        Avatar(
          onTap: () => showProfileSheet(context),
        ),
      ]
    );
  }
}
