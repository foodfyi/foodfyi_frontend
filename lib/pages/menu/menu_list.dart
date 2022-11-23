import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/pages/menu/menu_add.dart';
import 'package:foodfyi/pages/preview/preview.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  static final Dish loadingTag = Dish(id: -1, name: 'loading', price: -1);
  var _dishes = <Dish>[loadingTag];
  String searchString = "";

  @override
  void initState() {
    super.initState();
    // TODO: initial data
    setState(() {
      _dishes.insertAll(_dishes.length - 1, mockDishes);
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('menu'),
      ),
      persistentFooterButtons: [
        Center(
          child: IntrinsicWidth(
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const PreviewMenu(),
                  ),
                )
              },
              child: const Text("Release Menu"),
            ),
          ),
        ),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MenuAdd(barTitle: 'Add New Dish');
          }));
        }),
        tooltip: 'Add Dish',
        backgroundColor: pinkHeavyColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
