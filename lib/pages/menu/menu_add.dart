import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/allergy.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/models/flavor.dart';
import 'package:image_picker/image_picker.dart';

class MenuAdd extends StatefulWidget {
  const MenuAdd({super.key, required this.barTitle, this.oldDish});
  final String barTitle;
  final Dish? oldDish;

  @override
  State<MenuAdd> createState() => _MenuAddState();
}

class _MenuAddState extends State<MenuAdd> {
  Dish newDish = Dish(id: -1, name: '', price: -1);
  List<int> selectedAllergyChips = [];
  List<int> selectedFlavorChips = [];
  List<Allergy> allAllergies = [];
  List<Flavor> allFlavors = [];
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  final GlobalKey<FormState> _dishKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.oldDish != null) {
      newDish = widget.oldDish!;
    }
    allAllergies.insertAll(allAllergies.length, mockAllergies);
    allFlavors.insertAll(allFlavors.length, mockFlavors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.barTitle),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding * 2,
        ),
        child: Form(
          key: _dishKey,
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Name:'),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelStyle: textLargeSize,
                      ),
                      initialValue:
                          (widget.oldDish != null) ? widget.oldDish!.name : '',
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          newDish.name = value;
                        });
                      },
                      validator: (value) {
                        return value!.trim().isNotEmpty
                            ? null
                            : "Please enter dish name";
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding * 2),
              Row(
                children: [
                  const Text('Price:'),
                  const SizedBox(width: defaultPadding),
                  const Text('\$'),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'(^\d*\.?\d*)'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelStyle: textLargeSize,
                      ),
                      initialValue: (widget.oldDish != null)
                          ? widget.oldDish!.price.toString()
                          : '',
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          newDish.price = double.parse(value);
                        });
                      },
                      validator: (value) {
                        return value!.trim().isNotEmpty
                            ? null
                            : "Please enter dish price";
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding * 2),
              // Allergy Note
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 9,
                        child: Text('Allergy Note(Optional):'),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 0.5),
                  Wrap(
                    children:
                        _buildChoiceChips(allAllergies, selectedAllergyChips),
                  )
                ],
              ),
              const SizedBox(height: defaultPadding * 2),
              // Flavor Note
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 9,
                        child: Text('Flavor(Optional):'),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 0.5),
                  Wrap(
                    children:
                        _buildChoiceChips(allFlavors, selectedFlavorChips),
                  )
                ],
              ),
              const SizedBox(height: defaultPadding * 2),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Images:'),
                        const SizedBox(width: defaultPadding),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () {
                                selectImages();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: pinkLightColor,
                              ),
                              child: const Text('Upload')),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 0.5),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: imageFileList!.length,
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 4),
                        itemBuilder: (BuildContext context, int index) {
                          // Image.file can be used in iOS
                          return Image.network(
                            imageFileList![index].path,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_dishKey.currentState!.validate()) {
                            // TODO: send data
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChoiceChips(
      List<dynamic> allChips, List<int> selectedChips) {
    List<Widget> choices = [];
    for (var element in allChips) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(element.name),
          selected: selectedChips.contains(element.id),
          onSelected: (value) {
            setState(() {
              selectedChips.contains(element.id)
                  ? selectedChips.remove(element.id)
                  : selectedChips.add(element.id);
            });
          },
          selectedColor: pinkHeavyColor,
        ),
      ));
    }
    return choices;
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    // print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }
}
