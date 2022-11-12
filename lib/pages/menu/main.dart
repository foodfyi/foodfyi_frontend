import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/pages/utils/drawer.dart';

class MenuMain extends StatefulWidget {
  const MenuMain({super.key});

  @override
  State<MenuMain> createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('food.fyi'),
      ),
      drawer: const CommonDrawer(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: greyBackground),
          ),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_outlined), label: "Menu"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star_outline), label: "Comment"),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline), label: "Chat"),
          ],
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          fixedColor: pinkHeavyColor,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
