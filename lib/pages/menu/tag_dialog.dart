import 'package:foodfyi/constants.dart';
import 'package:flutter/material.dart';

Future<String> showAddTag({
  required BuildContext context,
  required String type,
}) async {
  final tagFormKey = GlobalKey<FormState>();
  String tagName = '';

  await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: ((context, setState) {
        return AlertDialog(
          title: Text('Add $type'),
          content: Container(
            width: dialogWidth,
            height: 0.5 * dialogHeight,
            alignment: Alignment.center,
            child: Form(
              key: tagFormKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: type,
                            labelStyle: textLargeSize,
                            enabledBorder: const UnderlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            setState(() {
                              tagName = value;
                            });
                          },
                          validator: (value) {
                            return value!.trim().isNotEmpty
                                ? null
                                : "This field cannot be empty";
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (tagFormKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      }),
    ),
  );

  return tagName;
}
