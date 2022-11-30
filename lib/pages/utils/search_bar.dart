import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: placeholderColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              hintText: "Search food name",
              prefixIcon: const Icon(Icons.search),
            ),
          )
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(defaultPadding),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       Expanded(
    //         flex: 3,
    //         child: SizedBox(
    //           height: 30,
    //           child: TextField(
    //             textAlignVertical: TextAlignVertical.bottom,
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(30),
    //               ),
    //               fillColor: placeholderColor,
    //               prefixIcon: const Icon(Icons.search, size: 20),
    //               hintText: "search food name",
    //               hintStyle: const TextStyle(
    //                 color: Colors.grey,
    //                 fontSize: 15,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       const Expanded(flex: 1, child: DropDownMenu()),
    //     ],
    //   ),
    // );
  }
}
