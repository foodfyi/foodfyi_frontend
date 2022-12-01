import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/pages/review/single_food_review_list.dart';

class DishList extends StatefulWidget {
  final List<int> dishIds;
  const DishList({super.key, required this.dishIds});

  @override
  State<DishList> createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.dishIds.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          var dishId = widget.dishIds[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SingleFoodReviewList(
                      dishId: dishId,
                    );
                  },
                ),
              );
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 20.0),
              decoration: BoxDecoration(
                  color: orangeLightColor,
                  border: Border.all(color: profileLabelColor, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(mockDishes[dishId].name,
                              style: textMiddleSize),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            const Icon(Icons.star_border, size: iconsize),
                            Text(
                                (mockDishes[dishId].rating == null)
                                    ? 'N/A'
                                    : mockDishes[dishId]
                                        .rating!
                                        .toStringAsFixed(1),
                                style: textMiddleSize),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            Text('\$${mockDishes[dishId].price}',
                                style: textMiddleSize)
                          ]),
                        )
                      ],
                    ),
                    ClipRRect(
                      borderRadius: border,
                      child: Image.network(
                        width: menuImgSize,
                        height: menuImgSize,
                        mockDishes[dishId].imgUrl![0],
                        fit: BoxFit.cover,
                      ),
                    ),
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
