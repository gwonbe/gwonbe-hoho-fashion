import 'package:flutter/material.dart';
import 'package:hoho_fashion/l10n/app_localizations.dart';

class ScreenStyling extends StatefulWidget {

  const ScreenStyling({super.key});

  @override
  State<ScreenStyling> createState() => _ScreenStyling();

}

class _ScreenStyling extends State<ScreenStyling> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.screen_styling),
          ],
        ),
      ),
    );
  }

}