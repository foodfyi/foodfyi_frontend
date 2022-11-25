import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/pages/review/dish_list.dart';

class SingleFoodReviewList extends StatefulWidget {
  static const routeName = "/singlefoodreview";
  // final Dish dish;
  const SingleFoodReviewList({super.key});
  // const SingleFoodReviewList({super.key, required this.dish});

  @override
  State<SingleFoodReviewList> createState() => _SingleFoodReviewListState();
}

class _SingleFoodReviewListState extends State<SingleFoodReviewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mockReviews.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      mockReviews[index].anonymous
                                          ? "Anonymous"
                                          : mockReviews[index].name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: mockReviews[index].rating,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star_rounded,
                                          color: pinkHeavyColor,
                                        ),
                                        itemSize: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(mockReviews[index].date,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: greyHeavyColor)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              mockReviews[index].anonymous
                                  ? const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                        width: 70,
                                        height: 40,
                                        child: Text('Refuse to connect'),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                          width: 70,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // TODO: navigate to chat
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: pinkHeavyColor,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                              ),
                                            ),
                                            child: const Text('Chat',
                                                style: textMiddleSize),
                                          )),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 5, bottom: 10),
                            child: Text(mockReviews[index].comment,
                                style: textMiddleSize),
                          ),
                          const DishList(
                            dishIds: [0],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
