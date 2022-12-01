import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/review.dart';
import 'package:foodfyi/pages/chat/chat_detail.dart';
import 'package:foodfyi/pages/review/dish_list.dart';

enum sortingBy { recent, rating }

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  sortingBy _scale = sortingBy.recent;
  List<Review> reviews = mockReviews.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: placeholderColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search food name",
                              prefixIcon: const Icon(Icons.search),
                            ),
                            onChanged: searchDish,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PopupMenuButton(
                        icon: const Icon(Icons.sort),
                        onSelected: (value) => setState(() {
                          _scale = value;
                          List<Review> sortedReviewsByRecent = reviews.toList()
                            ..sort((a, b) {
                              DateTime dt1 = DateTime.parse(a.date);
                              DateTime dt2 = DateTime.parse(b.date);
                              return dt1.compareTo(dt2);
                            });
                          List<Review> sortedReviewsByRating = reviews.toList()
                            ..sort((b, a) => a.rating.compareTo(b.rating));
                          reviews = _scale == sortingBy.recent
                              ? sortedReviewsByRecent
                              : sortedReviewsByRating;
                        }),
                        enableFeedback: false,
                        itemBuilder: (_) => [
                          CheckedPopupMenuItem(
                            checked: _scale == 'recent',
                            value: sortingBy.recent,
                            child: Row(
                              children: [
                                Checkbox(
                                    value: _scale == sortingBy.recent,
                                    onChanged: (value) {},
                                    shape: const CircleBorder()),
                                const Text('Sort By Recent'),
                              ],
                            ),
                          ),
                          CheckedPopupMenuItem(
                            checked: _scale == 'rating',
                            value: sortingBy.rating,
                            child: Row(
                              children: [
                                Checkbox(
                                    value: _scale == sortingBy.rating,
                                    onChanged: (value) {},
                                    shape: const CircleBorder()),
                                const Text('Sort By Rating'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviews.length,
                  physics: const NeverScrollableScrollPhysics(),
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
                                      reviews[index].anonymous
                                          ? "Anonymous"
                                          : reviews[index].name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: reviews[index].rating,
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
                                        child: Text(reviews[index].date,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: greyHeavyColor)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              !reviews[index].chatable
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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  String title =
                                                      'Chat Detail with ${mockChats[index].userName}';
                                                  return ChatDetail(
                                                      barTitle: title,
                                                      userId:
                                                          mockChats[index].id);
                                                }),
                                              );
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
                            child: Text(reviews[index].comment,
                                style: textMiddleSize),
                          ),
                          DishList(
                            dishIds: reviews[index].dishIds,
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

  void searchDish(String query) {
    var filteredReviews = mockReviews.where((review) {
      var input = query.toLowerCase();
      for (int i = 0; i < review.dishIds.length; i++) {
        var index = review.dishIds[i];
        var name = mockDishes[index].name.toLowerCase();
        if (name.contains(input)) {
          return true;
        } else {
          continue;
        }
      }
      return false;
    }).toList();
    setState(() {
      reviews = filteredReviews;
      _scale = sortingBy.recent;
    });
  }
}
