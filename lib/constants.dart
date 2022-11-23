import 'package:flutter/material.dart';
import 'package:foodfyi/models/dish.dart';

const pinkColor = Color(0xFFF2C6C2);
const pinkLightColor = Color(0xFFF2E8DF);
const pinkHeavyColor = Color(0xFFF28585);
const orangeColor = Color(0xFFF2B263);
const greenColor = Color(0xFF86A69D);
const greyColor = Color(0xFFC0C0C0);
const greyHeavyColor = Color(0xFF8a8a8a);
const greyBackground = Color(0xFFF5F5F5);
const profileLabelColor = Color(0xFFC2BAB2);

const double logoWidth = 100;
const double logoHeight = 100;
const logoTitleFont =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Cute');

const double defaultPadding = 16.0;
const border = BorderRadius.all(Radius.circular(10.0));

const TextStyle textLargeSize = TextStyle(fontSize: 20);
const TextStyle textMiddleSize = TextStyle(fontSize: 15);
const TextStyle textSmallSize = TextStyle(fontSize: 10);

const double imgWidth = 80.0;
const double imgHeight = 80.0;

const double dividerThickness = 1.5;

// maximum load size per page
const int menuLoadSize = 15;

// Mock Data
final mockDishes = <Dish>[
  Dish(id: 0, name: 'Burger & Soda', price: 8, rating: 5.0),
  Dish(id: 1, name: 'Hotdog', price: 6, rating: 5.0),
  Dish(id: 2, name: 'Sushi', price: 6, rating: 5.0),
];
