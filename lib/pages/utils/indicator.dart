import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(
    imagesLength,
    (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: currentIndex == index ? pinkColor : greyColor,
          shape: BoxShape.circle,
        ),
      );
    },
  );
}
