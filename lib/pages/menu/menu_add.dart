import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/allergy.dart';
import 'package:foodfyi/models/dish.dart';
import 'package:foodfyi/models/flavor.dart';
import 'package:foodfyi/pages/menu/tag_dialog.dart';
import 'package:image_picker/image_picker.dart';

class MenuAdd extends StatefulWidget {
  const MenuAdd({super.key, required this.barTitle, this.oldDish});
  final String barTitle;
  final Dish? oldDish;

  @override
  State<MenuAdd> createState() => _MenuAddState();
}

class _MenuAddState extends State<MenuAdd> {
  Dish newDish = Dish(id: -1, name: '', price: -1, imgUrl: []);
  final ImagePicker imagePicker = ImagePicker();
  final GlobalKey<FormState> _dishKey = GlobalKey<FormState>();
  bool showInValidImgText = false;
  bool _showTagDelete = false;

  @override
  void initState() {
    super.initState();
    if (widget.oldDish != null) {
      newDish = widget.oldDish!;
    }
    newDish.allergyNoteIds ??= [];
    newDish.flavorIds ??= [];
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
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
                            const Text(
                              'Name:',
                              style: textMiddleSize,
                            ),
                            const SizedBox(width: defaultPadding),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelStyle: textLargeSize,
                                ),
                                initialValue: (widget.oldDish != null)
                                    ? widget.oldDish!.name
                                    : '',
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
                            const Text(
                              'Price:',
                              style: textMiddleSize,
                            ),
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
                                  child: Text(
                                    'Allergy Note(Optional):',
                                    style: textMiddleSize,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () async {
                                      String allergy = await showAddTag(
                                        context: context,
                                        type: 'Allergy',
                                      );
                                      setState(
                                        () {
                                          if (allergy.trim().isNotEmpty) {
                                            mockAllergies.add(
                                              Allergy(
                                                id: mockAllergies.last.id + 1,
                                                name: allergy,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: defaultPadding * 0.5),
                            Wrap(
                              children: _buildChoiceChips(
                                  mockAllergies, newDish.allergyNoteIds!),
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
                                  child: Text(
                                    'Flavor(Optional):',
                                    style: textMiddleSize,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () async {
                                      String flavor = await showAddTag(
                                        context: context,
                                        type: 'Flavor',
                                      );
                                      setState(
                                        () {
                                          if (flavor.trim().isNotEmpty) {
                                            mockFlavors.add(
                                              Flavor(
                                                id: mockFlavors.last.id + 1,
                                                name: flavor,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: defaultPadding * 0.5),
                            Wrap(
                              children: _buildChoiceChips(
                                  mockFlavors, newDish.flavorIds!),
                            )
                          ],
                        ),
                        const SizedBox(height: defaultPadding * 2),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Images:',
                                  style: textMiddleSize,
                                ),
                                const SizedBox(width: defaultPadding),
                                SizedBox(
                                  height: 30,
                                  child: IntrinsicWidth(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        selectImages();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: pinkLightColor,
                                      ),
                                      child: const Text('Upload'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            showInValidImgText
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: defaultPadding),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Please upload at least 1 image',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: defaultPadding * 0.5),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: newDish.imgUrl!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: tagCrossAxisCount,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // Image.file can be used in iOS
                                return Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: ClipRRect(
                                        borderRadius: border,
                                        child: newDish.imgUrl![index]
                                                .startsWith('http')
                                            ? Image.network(
                                                newDish.imgUrl![index],
                                                width: imgWidth,
                                                height: imgHeight,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(newDish.imgUrl![index]),
                                                width: imgWidth,
                                                height: imgHeight,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            newDish.imgUrl!.removeAt(index);
                                          });
                                        },
                                        child: const Icon(Icons.close),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: defaultPadding),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (newDish.imgUrl == null ||
                                      newDish.imgUrl!.isEmpty) {
                                    setState(() {
                                      showInValidImgText = true;
                                    });
                                  } else {
                                    setState(() {
                                      showInValidImgText = false;
                                    });
                                  }
                                  if (_dishKey.currentState!.validate() &&
                                      !showInValidImgText) {
                                    setState(() {
                                      newDish.modified = true;
                                    });
                                    Navigator.pop(context, newDish);
                                  }
                                },
                                child: const Text('Confirm'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildChoiceChips(
      List<dynamic> allChips, List<int> selectedChips) {
    List<Widget> choices = [];
    for (var index = 0; index < allChips.length; index++) {
      var element = allChips[index];
      choices.add(
        GestureDetector(
          onLongPress: () => {
            setState((() {
              _showTagDelete = true;
            }))
          },
          child: _showTagDelete
              ? Container(
                  padding: const EdgeInsets.all(2.0),
                  child: InputChip(
                    label: Text(element.name),
                    selected: selectedChips.contains(element.id),
                    labelStyle: selectedChips.contains(element.id)
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
                    onSelected: (value) {
                      setState(() {
                        selectedChips.contains(element.id)
                            ? selectedChips.remove(element.id)
                            : selectedChips.add(element.id);
                      });
                    },
                    selectedColor: pinkHeavyColor,
                    showCheckmark: false,
                    deleteIcon: Icon(
                      Icons.close,
                      color: selectedChips.contains(element.id)
                          ? Colors.white
                          : Colors.black,
                    ),
                    onDeleted: () {
                      setState(() {
                        if (selectedChips.contains(element.id)) {
                          selectedChips.remove(element.id);
                        }
                        allChips.removeAt(index);
                      });
                    },
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(2.0),
                  child: InputChip(
                    label: Text(element.name),
                    selected: selectedChips.contains(element.id),
                    labelStyle: selectedChips.contains(element.id)
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
                    onSelected: (value) {
                      setState(() {
                        selectedChips.contains(element.id)
                            ? selectedChips.remove(element.id)
                            : selectedChips.add(element.id);
                      });
                    },
                    selectedColor: pinkHeavyColor,
                    showCheckmark: false,
                  ),
                ),
        ),
      );
    }
    return choices;
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    setState(() {
      if (selectedImages.isNotEmpty) {
        newDish.imgUrl ??= [];
        for (var index = 0; index < selectedImages.length; index++) {
          newDish.imgUrl!.add(selectedImages[index].path);
        }
      }
    });
  }
}
