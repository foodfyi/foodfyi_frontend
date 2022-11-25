import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/review.dart';

const List<String> dropDown = <String>['Sort By Recent', 'Sort By Ratings'];

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  List<Review> reviews = [];
  String dropdownValue = dropDown[0];

  @override
  void initState() {
    super.initState();
    setState(() {
      reviews = mockReviews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 100,
      child: DropdownButton<String>(
        icon: const Icon(Icons.sort),
        isExpanded: true,
        underline: Container(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: dropDown.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
