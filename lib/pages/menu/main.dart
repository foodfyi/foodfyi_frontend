import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/pages/menu/menu_list.dart';
import 'package:foodfyi/pages/review/review_list.dart';
import 'package:foodfyi/pages/chat/chat_list.dart';
import 'package:foodfyi/pages/utils/drawer.dart';

class MenuMain extends StatefulWidget {
  const MenuMain({super.key});

  @override
  State<MenuMain> createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain> {
  int _selectedIndex = 0;

  static final List<Widget> _appBarOptions = <Widget>[
    // Menu
    const Text('Edit Menu'),
    // Comments
    Column(
      children: [
        const Text(
          'Comments',
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.star_rounded,
              color: pinkHeavyColor,
              size: iconsize,
            ),
            Text(
              ' 4.5',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding * 0.5),
            ),
            Text(
              '4 reviews',
              style: TextStyle(fontSize: 15, color: greyHeavyColor),
            ),
          ],
        ),
      ],
    ),
    // Chat
    const Text('Chat List'),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    MenuList(),
    ReviewList(),
    ChatList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarOptions[_selectedIndex],
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const CommonDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
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
                icon: Icon(Icons.star_outline_rounded), label: "Comment"),
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
