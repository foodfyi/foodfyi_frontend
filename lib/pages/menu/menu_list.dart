import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/pages/menu/menu_add.dart';
import 'package:foodfyi/pages/preview/preview.dart';
import 'package:foodfyi/pages/review/single_food_review_list.dart';

class MenuList extends StatefulWidget {
  final List<Dish> unSavedDishes;
  const MenuList({super.key, required this.unSavedDishes});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  List<Dish> previewDishes = [];

  @override
  void initState() {
    super.initState();
    previewDishes = widget.unSavedDishes;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: previewDishes.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () async {
                            Dish? newDish = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => MenuAdd(
                                  barTitle: 'Edit Dish',
                                  oldDishIndex: index,
                                  allDishes: previewDishes,
                                ),
                              ),
                            );
                            setState(() {
                              if (newDish != null) {
                                previewDishes[index] = newDish;
                              }
                            });
                          },
                          icon: ClipRRect(
                            borderRadius: border,
                            child: previewDishes[index]
                                    .imgUrl![0]
                                    .startsWith('http')
                                ? Image.network(
                                    previewDishes[index].imgUrl![0],
                                    width: imgWidth,
                                    height: imgHeight,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(previewDishes[index].imgUrl![0]),
                                    width: imgWidth,
                                    height: imgHeight,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          iconSize: menuItemSize,
                        ),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.edit_outlined,
                            size: 20,
                            color: pinkHeavyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          previewDishes[index].name,
                          style: textLargeSize,
                        ),
                        const SizedBox(height: 0.5 * defaultPadding),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: pinkHeavyColor,
                              size: iconsize,
                            ),
                            Text(
                              (previewDishes[index].rating == null)
                                  ? 'N/A'
                                  : previewDishes[index]
                                      .rating!
                                      .toStringAsFixed(1),
                              style: textMiddleSize,
                            ),
                            const SizedBox(width: defaultPadding),
                            Text(
                              '\$${previewDishes[index].price}',
                              style: textMiddleSize,
                            ),
                          ],
                        ),
                        const SizedBox(height: 0.5 * defaultPadding),
                        SizedBox(
                          width: 90,
                          height: 20,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SingleFoodReviewList(
                                        dishId: index,
                                        hasStoreRating: false,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: pinkLightColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                              ),
                              child: const Text('Reviews')),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: previewDishes[index].modified!
                        ? IntrinsicWidth(
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: greenColor),
                                borderRadius: border,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Unreleased',
                                style: TextStyle(
                                  color: greenColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Dish'),
                          content:
                              const Text('Are you sure you want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  previewDishes.removeAt(index);
                                });
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 0.5 * defaultPadding),
                ],
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: IntrinsicWidth(
            child: ElevatedButton(
              onPressed: () async {
                List<Dish>? newMockDish = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PreviewMenu(
                      unSavedDishes: previewDishes,
                    ),
                  ),
                );
                if (newMockDish != null) {
                  setState(() {
                    previewDishes = newMockDish;
                  });
                }
              },
              child: const Text("Release Menu"),
            ),
          ),
        ),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Dish? newDish = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return MenuAdd(
                barTitle: 'Add New Dish',
                allDishes: previewDishes,
              );
            }),
          );
          setState(() {
            if (newDish != null) {
              previewDishes.add(newDish);
            }
          });
        },
        tooltip: 'Add Dish',
        backgroundColor: pinkHeavyColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
