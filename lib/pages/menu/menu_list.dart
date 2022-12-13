import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/pages/menu/menu_add.dart';
import 'package:foodfyi/pages/preview/preview.dart';
import 'package:foodfyi/pages/review/single_food_review_list.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
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
          itemCount: mockDishes.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.5),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: border,
                    child: Image.network(
                      width: menuImgSize,
                      height: menuImgSize,
                      mockDishes[index].imgUrl![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mockDishes[index].name,
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
                              (mockDishes[index].rating == null)
                                  ? 'N/A'
                                  : mockDishes[index]
                                      .rating!
                                      .toStringAsFixed(1),
                              style: textMiddleSize,
                            ),
                            const SizedBox(width: defaultPadding),
                            Text(
                              '\$${mockDishes[index].price}',
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
                    child: mockDishes[index].modified!
                        ? Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: greenColor),
                              borderRadius: border,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Modified',
                              style: TextStyle(
                                color: greenColor,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () async {
                        Dish? newDish = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MenuAdd(
                              barTitle: 'Edit Dish',
                              oldDish: mockDishes[index],
                            ),
                          ),
                        );
                        setState(() {
                          if (newDish != null) {
                            mockDishes[index] = newDish;
                          }
                        });
                      },
                    ),
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
                                  mockDishes.removeAt(index);
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
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PreviewMenu(
                      unSavedDishes: mockDishes,
                    ),
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
        onPressed: () async {
          Dish? newDish = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const MenuAdd(barTitle: 'Add New Dish');
            }),
          );
          setState(() {
            if (newDish != null) {
              mockDishes.add(newDish);
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
