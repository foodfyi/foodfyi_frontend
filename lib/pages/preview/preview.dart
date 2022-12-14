import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/pages/preview/detail.dart';
import 'package:foodfyi/pages/utils/indicator.dart';

class PreviewMenu extends StatefulWidget {
  final List<Dish> unSavedDishes;
  const PreviewMenu({super.key, required this.unSavedDishes});

  @override
  State<PreviewMenu> createState() => _PreviewMenuState();
}

class _PreviewMenuState extends State<PreviewMenu> {
  List<Dish> previewDishes = [];

  @override
  void initState() {
    super.initState();
    previewDishes = widget.unSavedDishes;
    for (int i = 0; i < widget.unSavedDishes.length; i++) {
      previewDishes[i].allergyNoteIds =
          findExistIds(mockAllergies, widget.unSavedDishes[i].allergyNoteIds);
      previewDishes[i].flavorIds =
          findExistIds(mockFlavors, widget.unSavedDishes[i].flavorIds);
    }
  }

  void clearDishStatus() {
    for (int i = 0; i < previewDishes.length; i++) {
      setState(() {
        previewDishes[i].modified = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Preview Student Side'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: previewDishes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5 * defaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: previewImg + defaultPadding,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  controller: PageController(
                                    initialPage:
                                        previewDishes[index].activeImgPage!,
                                  ),
                                  itemCount:
                                      previewDishes[index].imgUrl!.length,
                                  onPageChanged: (value) {
                                    setState(() {
                                      previewDishes[index].activeImgPage =
                                          value;
                                    });
                                  },
                                  itemBuilder: (context, pagePosition) {
                                    return IconButton(
                                      icon: ClipRRect(
                                        borderRadius: border,
                                        child: previewDishes[index]
                                                .imgUrl![pagePosition]
                                                .startsWith('http')
                                            ? Image.network(
                                                previewDishes[index]
                                                    .imgUrl![pagePosition],
                                                width: previewImg,
                                                height: previewImg,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(previewDishes[index]
                                                    .imgUrl![pagePosition]),
                                                width: previewImg,
                                                height: previewImg,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return DishDetail(
                                                dish: previewDishes[index],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                previewDishes[index].imgUrl!.length == 1
                                    ? Container()
                                    : Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: indicators(
                                            previewDishes[index].imgUrl!.length,
                                            previewDishes[index].activeImgPage,
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        Expanded(
                          flex: 2,
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
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                    ),
                                  ),
                                  Text(
                                    '\$${previewDishes[index].price}',
                                    style: textMiddleSize,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 0.5 * defaultPadding),
                              previewDishes[index].allergyNoteIds != null &&
                                      previewDishes[index]
                                          .allergyNoteIds!
                                          .isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 0.5 * defaultPadding,
                                      ),
                                      child: SizedBox(
                                        height: tagSize,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: previewDishes[index]
                                              .allergyNoteIds!
                                              .length,
                                          itemBuilder: (_, allergyIndex) {
                                            return IntrinsicWidth(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right:
                                                        0.5 * defaultPadding),
                                                child: TextButton(
                                                  onPressed: null,
                                                  style: previewTagStyle,
                                                  child: Text(
                                                    getName(
                                                      mockAllergies,
                                                      previewDishes[index]
                                                              .allergyNoteIds![
                                                          allergyIndex],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),
                              previewDishes[index].flavorIds != null &&
                                      previewDishes[index].flavorIds!.isNotEmpty
                                  ? SizedBox(
                                      height: tagSize,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: previewDishes[index]
                                            .flavorIds!
                                            .length,
                                        itemBuilder: (_, flavorIndex) {
                                          return IntrinsicWidth(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0.5 * defaultPadding),
                                              child: TextButton(
                                                onPressed: null,
                                                style: previewTagStyle,
                                                child: Text(
                                                  getName(
                                                    mockFlavors,
                                                    previewDishes[index]
                                                            .flavorIds![
                                                        flavorIndex],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: IntrinsicWidth(
            child: ElevatedButton(
              onPressed: () {
                clearDishStatus();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Release Menu successfully'),
                  ),
                );
                Navigator.pop(context, previewDishes);
              },
              child: const Text("Release Menu"),
            ),
          ),
        ),
      ],
    );
  }
}
