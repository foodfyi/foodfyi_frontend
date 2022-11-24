import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/pages/preview/detail.dart';

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
          horizontal: 0.5 * defaultPadding,
          vertical: defaultPadding,
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
                            child: PageView.builder(
                              itemCount: previewDishes[index].imgUrl!.length,
                              itemBuilder: (context, pagePosition) {
                                return IconButton(
                                  icon: ClipRRect(
                                    borderRadius: border,
                                    child: Image.network(
                                      width: previewImg,
                                      height: previewImg,
                                      previewDishes[index]
                                          .imgUrl![pagePosition],
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
                              previewDishes[index].allergyNoteIds != null
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
                                            List<int> allergies =
                                                previewDishes[index]
                                                    .allergyNoteIds!;
                                            return IntrinsicWidth(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right:
                                                        0.5 * defaultPadding),
                                                child: TextButton(
                                                  onPressed: null,
                                                  style: previewTagStyle,
                                                  child: Text(mockAllergies[
                                                          allergies[
                                                              allergyIndex]]
                                                      .name),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),
                              previewDishes[index].flavorIds != null
                                  ? SizedBox(
                                      height: tagSize,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: previewDishes[index]
                                            .flavorIds!
                                            .length,
                                        itemBuilder: (_, flavorIndex) {
                                          List<int> flavors =
                                              previewDishes[index].flavorIds!;
                                          return IntrinsicWidth(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0.5 * defaultPadding),
                                              child: TextButton(
                                                onPressed: null,
                                                style: previewTagStyle,
                                                child: Text(mockFlavors[
                                                        flavors[flavorIndex]]
                                                    .name),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Save Menu successfully'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Release Menu"),
            ),
          ),
        ),
      ],
    );
  }
}
