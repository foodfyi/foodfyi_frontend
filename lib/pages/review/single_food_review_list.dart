import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/pages/chat/chat_detail.dart';
import 'package:foodfyi/pages/review/dish_list.dart';

class SingleFoodReviewList extends StatefulWidget {
  final int dishId;
  final bool hasStoreRating;
  const SingleFoodReviewList(
      {super.key, required this.dishId, required this.hasStoreRating});

  @override
  State<SingleFoodReviewList> createState() => _SingleFoodReviewListState();
}

class _SingleFoodReviewListState extends State<SingleFoodReviewList> {
  @override
  Widget build(BuildContext context) {
    final int dishId = widget.dishId;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            const Text(
              'Comments',
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: pinkHeavyColor,
                  size: iconsize,
                ),
                Text(
                  (mockDishes[dishId].rating == null)
                      ? 'N/A'
                      : mockDishes[dishId].rating!.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultPadding * 0.5),
                ),
                Text(
                  '${mockDishes[dishId].reviewIds != null ? mockDishes[dishId].reviewIds?.length : 'N/A'} reviews',
                  style: const TextStyle(fontSize: 15, color: greyHeavyColor),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: mockDishes[dishId].reviewIds != null
            ? Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: mockDishes[dishId].reviewIds?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final int reviewId =
                              mockDishes[dishId].reviewIds![index];
                          final bool? isRelated = mockDishes[dishId]
                              .relatedReviewIds
                              ?.contains(reviewId);
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(bottom: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, bottom: 5),
                                          child: Text(
                                            mockReviews[reviewId].anonymous
                                                ? "Anonymous"
                                                : mockReviews[reviewId].name,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            widget.hasStoreRating == true
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: RatingBarIndicator(
                                                      rating:
                                                          mockReviews[reviewId]
                                                              .rating,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              const Icon(
                                                        Icons.star_rounded,
                                                        color: pinkHeavyColor,
                                                      ),
                                                      itemSize: 20,
                                                    ))
                                                : const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: SizedBox()),
                                            Text(mockReviews[reviewId].date,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: greyHeavyColor)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    !mockReviews[reviewId].chatable
                                        ? const Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: SizedBox(
                                              width: 70,
                                              height: 40,
                                              child: Text('Refuse to connect'),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: SizedBox(
                                                width: 70,
                                                height: 40,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    var id = 0;
                                                    for (int i = 0;
                                                        i < mockChats.length;
                                                        i++) {
                                                      if (mockReviews[reviewId]
                                                              .anonymous &&
                                                          mockChats[i]
                                                                  .userName ==
                                                              "Anonymous") {
                                                        id = i;
                                                        break;
                                                      } else if (!mockReviews[
                                                                  reviewId]
                                                              .anonymous &&
                                                          mockChats[i]
                                                                  .userName ==
                                                              mockReviews[
                                                                      reviewId]
                                                                  .name) {
                                                        id = i;
                                                        break;
                                                      }
                                                    }
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                        return ChatDetail(
                                                            userName:
                                                                mockChats[id]
                                                                    .userName,
                                                            userId:
                                                                mockChats[id]
                                                                    .id);
                                                      }),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        pinkHeavyColor,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                    ),
                                                  ),
                                                  child: const Text('Chat',
                                                      style: textMiddleSize),
                                                )),
                                          ),
                                  ],
                                ),
                                isRelated == true
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 5, bottom: 10),
                                        child: Text(
                                            mockReviews[reviewId].comment,
                                            style: textMiddleSize),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.only(bottom: 15)),
                                DishList(
                                  dishIds: [dishId],
                                  clickable: false,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
