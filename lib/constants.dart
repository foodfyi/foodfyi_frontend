import 'package:flutter/material.dart';
import 'package:foodfyi/models/allergy.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/models/flavor.dart';

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

const double previewImg = 150;
const double iconsize = 15;
const double tagSize = 25;

ButtonStyle previewTagStyle = TextButton.styleFrom(
  elevation: 0,
  disabledForegroundColor: Colors.white,
  disabledBackgroundColor: pinkHeavyColor,
  textStyle: textSmallSize,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

// maximum load size per page
const int menuLoadSize = 15;

// Mock Data
final mockDishes = <Dish>[
  Dish(
    id: 0,
    name: 'Oat Meal',
    price: 8,
    rating: 5.0,
    allergyNoteIds: [5, 6, 7, 8],
    flavorIds: [0],
    imgUrl: [
      'https://brokebankvegan.com/wp-content/uploads/2021/02/Mexican-Oatmeal-8.jpg',
    ],
  ),
  Dish(
    id: 1,
    name: 'Bagels',
    price: 6,
    rating: 4.5,
    imgUrl: [
      'https://dining.columbia.edu/sites/default/files/2019-06/bagels.jpg',
      'https://www.kingarthurbaking.com/sites/default/files/2021-12/step-18.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/1/1d/Bagel-Plain-Alt.jpg'
    ],
    allergyNoteIds: [9],
  ),
  Dish(
    id: 2,
    name: 'Smoothies',
    price: 6,
    rating: 5.0,
    allergyNoteIds: [5],
    flavorIds: [0],
    imgUrl: [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Kiwi_Smoothie.jpg/1920px-Kiwi_Smoothie.jpg',
      'https://klcode-images.imgix.net/EefrZokeQyK0iGA4heul_kale-pineapple-coconut-smoothie.jpg',
    ],
  ),
  Dish(
    id: 3,
    name: 'Scrambled Eggs',
    price: 4,
    rating: 4.8,
    allergyNoteIds: [6, 7, 9],
    imgUrl: [
      'https://www.savoryexperiments.com/wp-content/uploads/2020/03/scrambled-eggs-1.jpg',
    ],
  ),
  Dish(
    id: 4,
    name: 'PanCakes',
    price: 7,
    rating: 4.9,
    allergyNoteIds: [7, 9],
    flavorIds: [0],
    imgUrl: [
      'https://dining.columbia.edu/sites/default/files/2019-06/pancakes.jpeg',
    ],
  ),
  Dish(
    id: 5,
    name: 'Roasted Cauliflower',
    price: 7,
    rating: 4.9,
    allergyNoteIds: [5, 6, 7],
    imgUrl: [
      'https://dining.columbia.edu/sites/default/files/2019-07/roasted_cauliflower.jpg',
    ],
  ),
  Dish(
    id: 6,
    name: 'Tater Tots',
    price: 9,
    rating: 4.7,
    allergyNoteIds: [5, 7],
    imgUrl: [
      'https://dining.columbia.edu/sites/default/files/2019-07/iStock-576894832.jpg',
    ],
  ),
  Dish(
    id: 7,
    name: 'Chicken Sausage',
    price: 5,
    rating: 4.7,
    allergyNoteIds: [2, 6],
    flavorIds: [6],
    imgUrl: [
      'https://wholelottayum.com/wp-content/uploads/2021/07/air-fryer-chicken-sausage.jpg'
    ],
  ),
  Dish(
    id: 8,
    name: 'French Toast',
    price: 8,
    rating: 5.0,
    allergyNoteIds: [5],
    flavorIds: [6],
    imgUrl: [
      'https://dining.columbia.edu/sites/default/files/2019-07/french%20toast_0.jpg',
    ],
  ),
  Dish(
    id: 9,
    name: 'Waffles',
    price: 3,
    rating: 4.9,
    allergyNoteIds: [5],
    flavorIds: [0],
    imgUrl: [
      'https://goboldwithbutter.com/BoldWithButter/media/recipe_images/Imported/buttermilk-grits-waffles.jpg'
    ],
  ),
];

final mockAllergies = <Allergy>[
  Allergy(id: 0, name: 'Beef'),
  Allergy(id: 1, name: 'Pork'),
  Allergy(id: 2, name: 'Chicken'),
  Allergy(id: 3, name: 'Seafood'),
  Allergy(id: 4, name: 'Lamb'),
  Allergy(id: 5, name: 'Vegan'),
  Allergy(id: 6, name: 'Gluten Free'),
  Allergy(id: 7, name: 'Halal'),
  Allergy(id: 8, name: 'Lactose'),
  Allergy(id: 9, name: 'Egg'),
];

final mockFlavors = <Flavor>[
  Flavor(id: 0, name: 'Sweet'),
  Flavor(id: 1, name: 'Very Sweet'),
  Flavor(id: 2, name: 'Sour'),
  Flavor(id: 3, name: 'Very Sour'),
  Flavor(id: 4, name: 'Spicy'),
  Flavor(id: 5, name: 'Very Spicy'),
  Flavor(id: 6, name: 'Salty'),
  Flavor(id: 7, name: 'Very Salty'),
];
