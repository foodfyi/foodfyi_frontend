import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/dish.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2 * defaultPadding,
          horizontal: defaultPadding,
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
                      itemCount: widget.dish.imgUrl!.length,
                      itemBuilder: (context, pagePosition) {
                        return ClipRRect(
                          borderRadius: border,
                          child: Image.network(
                            width: previewDishImg,
                            height: previewDishImg,
                            widget.dish.imgUrl![pagePosition],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            widget.dish.allergyNoteIds != null
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
                            itemCount: widget.dish.allergyNoteIds!.length,
                            itemBuilder: (_, allergyIndex) {
                              List<int> allergies = widget.dish.allergyNoteIds!;
                              return Center(
                                child: TextButton(
                                  onPressed: null,
                                  style: previewTagStyle,
                                  child: Text(
                                      mockAllergies[allergies[allergyIndex]]
                                          .name),
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
            widget.dish.flavorIds != null
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
                              List<int> flavors = widget.dish.flavorIds!;
                              return Center(
                                child: TextButton(
                                  onPressed: null,
                                  style: previewTagStyle,
                                  child: Text(
                                      mockFlavors[flavors[flavorIndex]].name),
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
    );
  }
}
