import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/pages/utils/indicator.dart';

class DishDetail extends StatefulWidget {
  final Dish dish;
  const DishDetail({super.key, required this.dish});

  @override
  State<DishDetail> createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
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
        title: const Text('Preview Dish Detail'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 2 * defaultPadding,
                  left: defaultPadding,
                  right: defaultPadding,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.dish.name,
                          style: titleSize,
                        )
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: previewDishImg,
                            height: previewDishImg,
                            child: PageView.builder(
                              controller: PageController(
                                initialPage: widget.dish.activeImgPage!,
                              ),
                              itemCount: widget.dish.imgUrl!.length,
                              onPageChanged: (value) {
                                setState(() {
                                  widget.dish.activeImgPage = value;
                                });
                              },
                              itemBuilder: (context, pagePosition) {
                                return ClipRRect(
                                  borderRadius: border,
                                  child: widget.dish.imgUrl![pagePosition]
                                          .startsWith('http')
                                      ? Image.network(
                                          widget.dish.imgUrl![pagePosition],
                                          width: previewDishImg,
                                          height: previewDishImg,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(widget
                                              .dish.imgUrl![pagePosition]),
                                          width: previewDishImg,
                                          height: previewDishImg,
                                          fit: BoxFit.cover,
                                        ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    widget.dish.imgUrl!.length == 1
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(
                              widget.dish.imgUrl!.length,
                              widget.dish.activeImgPage,
                            ),
                          ),
                    widget.dish.allergyNoteIds != null &&
                            widget.dish.allergyNoteIds!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Allergy Note',
                                  style: textLargeSize,
                                ),
                                SizedBox(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        widget.dish.allergyNoteIds!.length,
                                    itemBuilder: (_, allergyIndex) {
                                      return Center(
                                        child: TextButton(
                                          onPressed: null,
                                          style: previewTagStyle,
                                          child: Text(
                                            getName(
                                                mockAllergies, allergyIndex),
                                          ),
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: tagCrossAxisCount,
                                      mainAxisExtent: tagHeight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    widget.dish.flavorIds != null &&
                            widget.dish.flavorIds!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Flavor',
                                  style: textLargeSize,
                                ),
                                SizedBox(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.dish.flavorIds!.length,
                                    itemBuilder: (_, flavorIndex) {
                                      return Center(
                                        child: TextButton(
                                          onPressed: null,
                                          style: previewTagStyle,
                                          child: Text(
                                            getName(mockFlavors, flavorIndex),
                                          ),
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: tagCrossAxisCount,
                                      mainAxisExtent: tagHeight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
