import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoho_fashion/constants/constants.dart';
import 'package:hoho_fashion/l10n/app_localizations.dart';

class ScreenStyling extends StatefulWidget {

  const ScreenStyling({super.key});

  @override
  State<ScreenStyling> createState() => _ScreenStyling();

}

class _ScreenStyling extends State<ScreenStyling> {

  String tag = "[ScreenStyling]";
  Map<String, List<String>> items = {};
  String currentCategory = Category.eyes;
  late Map<String, String?> equipped;
  final imagePath = "assets/image/character/";

  final List<String> categories = [
    Category.eyes,
    Category.hair,
    Category.lips,
    Category.dress,
    Category.cloth1,
    Category.cloth2,
    Category.shoes,
    Category.hairband,
    Category.necklace,
  ];

  @override
  void initState() {
    super.initState();
    equipped = {
      for (var category in categories) category: null,
    };
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildCharacter(),
            buildCategoryMenu(),
            Expanded(child: buildItemGrid()),
          ],
        ),
      ),
    );
  }

  Future<void> loadItems() async {
    final jsonString = await rootBundle.loadString('assets/data/character_items.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    final Map<String, List<String>> loadedItems = {};
    data.forEach((key, value) {
      if (value is List) loadedItems[key] = value.map((e) => e.toString()).toList();
    });
    setState(() { items = loadedItems; });
  }

  void applyItem(String category, String path) {
    setState(() {
      if (equipped[category] == path) {
        equipped[category] = null;
      } else {
        equipped[category] = path;
        if (category == Category.dress) {
          equipped[Category.cloth1] = null;
          equipped[Category.cloth2] = null;
        } else if (category == Category.cloth1 || category == Category.cloth2) {
          equipped[Category.dress] = null;
        }
      }
    });
  }

  Widget buildCharacter() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final area = 350.0;
    final ratio = 0.8;
    debugPrint("$tag screenWidth : $screenWidth , screenHeight : $screenHeight");
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: area,
          maxHeight: area,
        ),
        child: SizedBox(
          width: screenWidth * ratio,
          height: screenHeight * ratio,
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: RepaintBoundary(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/image/character/body.png', fit: BoxFit.contain,),
                  ...categories.map((category) {
                    final item = equipped[category];
                    if (item == null) return const SizedBox.shrink();
                    return Image.asset(imagePath+item, fit: BoxFit.contain,);
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryMenu() {
    double area = 60;
    return SizedBox(
      height: area + 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == currentCategory;
          return Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () { setState((){currentCategory=cat;}); },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: area,
                height: area,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pink.withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.pink : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: isSelected ? Colors.pink.withOpacity(0.15) : Colors.transparent,
                    child: Image.asset('assets/icon/category/category_$cat.webp', fit: BoxFit.contain,),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildItemGrid() {
    double spacing = 8;
    if (items.isEmpty) return const Center(child: CircularProgressIndicator());
    final list = items[currentCategory] ?? [];
    if (list.isEmpty) return const Center(child: Text('No Item'));
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (context, index) {
        final path = list[index];
        return GestureDetector(
          onTap: () => applyItem(currentCategory, path),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey),),
            child: Image.asset(imagePath+path, fit: BoxFit.contain, cacheWidth: 200,),
          ),
        );
      },
    );
  }

}