import 'package:flutter/material.dart';
import 'package:hoho_fashion/l10n/app_localizations.dart';
import 'package:hoho_fashion/screen/home/section_button.dart';
import 'package:hoho_fashion/tab_navigation.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> _tabTitles = ["", "",];

  @override
  Widget build(BuildContext context) {

    _tabTitles[0] = AppLocalizations.of(context)!.screen_styling;
    _tabTitles[1] = AppLocalizations.of(context)!.screen_settings;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // 최소 높이만 차지
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SectionButton(
                      text: _tabTitles[0],
                      iconData: Icons.checkroom,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TabNavigation(initialTabIndex: 0),),
                        );
                      },
                    ),
                    SectionButton(
                      text: _tabTitles[1],
                      iconData: Icons.settings,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TabNavigation(initialTabIndex: 1),),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

}
