import 'package:flutter/material.dart';
import 'package:foodfyi/models/allergy.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/models/flavor.dart';
import 'package:foodfyi/models/merchant.dart';
import 'package:foodfyi/models/message.dart';
import 'package:foodfyi/models/review.dart';
import 'package:foodfyi/models/chat.dart';

const pinkColor = Color(0xFFF2C6C2);
const pinkLightColor = Color(0xFFF2E8DF);
const pinkHeavyColor = Color(0xFFF28585);
const orangeColor = Color(0xFFF2B263);
const orangeLightColor = Color.fromARGB(255, 251, 246, 235);
const greenColor = Color(0xFF86A69D);
const greyColor = Color(0xFFC0C0C0);
const greyHeavyColor = Color(0xFF8a8a8a);
const greyBackground = Color(0xFFF5F5F5);
const profileLabelColor = Color(0xFFC2BAB2);
const placeholderColor = Color.fromRGBO(217, 217, 217, 0.5);

const double logoWidth = 100;
const double logoHeight = 100;
const logoTitleFont =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Cute');

const chatTimeFont =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: greyColor);

const double defaultPadding = 16.0;
const border = BorderRadius.all(Radius.circular(10.0));

const TextStyle textLargeSize = TextStyle(fontSize: 20);
const TextStyle textMiddleSize = TextStyle(fontSize: 15);
const TextStyle textSmallSize = TextStyle(fontSize: 10);
const TextStyle titleSize = TextStyle(fontSize: 30);

const double imgWidth = 80.0;
const double imgHeight = 80.0;

const double dividerThickness = 1.5;

const double previewImg = 150;
const double menuImgSize = 60;
const double iconsize = 15;
const double tagSize = 25;
const double previewDishImg = 300;
const int tagCrossAxisCount = 4;
const double tagHeight = 50;

const double dialogWidth = 320;
const double dialogHeight = 400;

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
final List<Dish> mockDishes = <Dish>[
  Dish(
    id: 0,
    name: 'Oat Meal',
    price: 8,
    rating: 5.0,
    allergyNoteIds: [5, 6, 7, 8],
    flavorIds: [0],
    reviewIds: [0, 1, 2],
    relatedReviewIds: [0, 1],
    imgUrl: [
      'https://brokebankvegan.com/wp-content/uploads/2021/02/Mexican-Oatmeal-8.jpg',
    ],
  ),
  Dish(
    id: 1,
    name: 'Bagels',
    price: 6,
    rating: 4.5,
    reviewIds: [0, 1],
    relatedReviewIds: [1],
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
    reviewIds: [1],
    relatedReviewIds: [1],
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
    reviewIds: [1],
    relatedReviewIds: [1],
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
    reviewIds: [1, 2],
    relatedReviewIds: [1, 2],
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
    reviewIds: [0, 1, 2],
    relatedReviewIds: [1],
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
    reviewIds: [1, 3],
    relatedReviewIds: [1],
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
    reviewIds: [1, 2, 3],
    relatedReviewIds: [1, 3],
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
    reviewIds: [1, 3],
    relatedReviewIds: [1],
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
    reviewIds: [1],
    relatedReviewIds: [1],
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

final mockReviews = <Review>[
  Review(
    id: 0,
    date: '2022-11-12',
    comment: 'Oat meal tastes good',
    name: 'Steve A',
    anonymous: false,
    chatable: true,
    dishIds: [0, 1, 5],
    rating: 4.5,
  ),
  Review(
    id: 1,
    date: '2022-11-11',
    comment: 'Awesome food',
    name: 'Steve B',
    anonymous: false,
    chatable: false,
    dishIds: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    rating: 5.0,
  ),
  Review(
    id: 2,
    date: '2022-10-28',
    comment: 'Pancakes are very delicious, highly recommended',
    name: 'Steve A',
    anonymous: true,
    chatable: true,
    dishIds: [4, 5, 7, 0],
    rating: 3.0,
  ),
  Review(
    id: 3,
    date: '2022-10-10',
    comment: 'The chicken sausage is a little bit spicy',
    name: 'Steve C',
    anonymous: false,
    chatable: true,
    dishIds: [6, 7, 8],
    rating: 4.0,
  ),
];

final mockChats = <Chat>[
  Chat(
      id: 0,
      userName: "Steve A",
      missingCnt: 1,
      lastTime: "09:00 AM",
      avatarUrl: "/assets/images/user1.png"),
  Chat(
      id: 2,
      userName: "Anonymous User 1",
      missingCnt: 0,
      lastTime: "10-19",
      avatarUrl: "/assets/images/anonymous.png"),
];

final Map<int, List<Message>> mockMessages = {
  0: <Message>[
    Message(
        id: 0,
        fromId: 9999,
        direction: 0,
        userName: mockMerchant.name,
        text:
            "Hi, I am the owner of John Jay Hall, I found that you commented that the pizza is too salty. We have received your advice and our chef will improve on that. Are there any other dishes you find not good?",
        time: "2022-10-20 08:50 AM",
        avatarUrl: "/assets/images/merchant-member.png"),
    Message(
        id: 1,
        fromId: 0,
        direction: 1,
        userName: "Steve A.",
        text:
            "Thanks for reaching out. I am glad that you take my advice. And I forget to say that the vegetables in the burger are not fresh. I wish it would improve as well.",
        time: "2022-10-20 08:52 AM",
        avatarUrl: "/assets/images/user1.png")
  ],
  2: <Message>[
    Message(
        id: 2,
        fromId: 9999,
        direction: 0,
        userName: mockMerchant.name,
        text:
            "Hi, I am the owner of John Jay Hall, I found that you commented that the pizza is too salty. We have received your advice and our chef will improve on that. Are there any other dishes you find not good?",
        time: "2022-10-20 08:50 AM",
        avatarUrl: "/assets/images/merchant-member.png"),
    Message(
        id: 3,
        fromId: 2,
        direction: 1,
        userName: "Anonymous User 1",
        text:
            "Thanks for reaching out. I am glad that you take my advice. And I forget to say that the vegetables in the burger are not fresh. I wish it would improve as well.",
        time: "2022-10-20 08:52 AM",
        avatarUrl: "/assets/images/anonymous.png")
  ],
  1: <Message>[],
  3: <Message>[],
};

Merchant mockMerchant = Merchant(
  id: 0,
  merchantName: 'John Jay Hall',
  name: 'JJ Hall member 1',
  email: 'jjmember@gmail.com',
  avatar: '',
  phone: '123-456-7890',
);
