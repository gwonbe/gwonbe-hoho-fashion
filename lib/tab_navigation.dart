import 'package:flutter/material.dart';
import 'package:hoho_fashion/l10n/app_localizations.dart';
import 'package:hoho_fashion/screen/screen_settings.dart';
import 'package:hoho_fashion/screen/screen_styling.dart';

class TabNavigation extends StatefulWidget {

  final int initialTabIndex;

  const TabNavigation({super.key, this.initialTabIndex = 0});

  @override
  TabNavigationState createState() => TabNavigationState();

}

class TabNavigationState extends State<TabNavigation> {

  late PageController _pageController;
  int _currentIndex = 0;
  final List<String> _tabTitles = ["", "",];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialTabIndex);
    _currentIndex = widget.initialTabIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {_currentIndex = index;});
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {

    _tabTitles[0] = AppLocalizations.of(context)!.screen_styling;
    _tabTitles[1] = AppLocalizations.of(context)!.screen_settings;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // AppBar의 높이를 설정
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: true, // 기본 뒤로가기 버튼 표시
            title: Text(_tabTitles[_currentIndex]), // 기본 title을 null로 설정
            leading: IconButton(
              icon: Icon(Icons.arrow_back), // 기본 뒤로가기 아이콘
              onPressed: () {
                Navigator.pop(context); // 뒤로가기 버튼 동작
              },
            ),
            backgroundColor: Colors.white, // AppBar 배경색
            elevation: 0, // 그림자 없애기
            centerTitle: true, // 기본적으로 타이틀을 가운데 배치하려면 true 설정
          ),
        ),
      ),
      // 섹션별 내용
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Center(child: ScreenStyling()),
          Center(child: ScreenSettings()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).focusColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: _tabTitles[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: _tabTitles[1],
          ),
        ],
      ),
    );
  }

}