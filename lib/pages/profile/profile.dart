import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/merchant.dart';

class Profile extends StatefulWidget {
  final Merchant merchant;
  const Profile({super.key, required this.merchant});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _profileFormKey = GlobalKey<FormState>();
  Merchant changedMerchant = Merchant(
    id: 0,
    merchantName: '',
    name: '',
    email: '',
  );

  @override
  void initState() {
    super.initState();
    changedMerchant = widget.merchant;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Edit Profile'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _profileFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPadding * 2),
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  changedMerchant.avatar == ''
                                      ? "assets/images/merchant-member.png"
                                      : changedMerchant.avatar!,
                                  width: imgWidth,
                                ),
                              ),
                              const SizedBox(height: 0.5 * defaultPadding),
                              Text(changedMerchant.email),
                              const SizedBox(height: 0.5 * defaultPadding),
                              Text(
                                  'Belongs to ${changedMerchant.merchantName}'),
                              const SizedBox(height: 2 * defaultPadding),
                            ],
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              labelStyle: textLargeSize,
                              enabledBorder: UnderlineInputBorder(),
                            ),
                            initialValue: changedMerchant.name,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              setState(() {
                                changedMerchant.name = value;
                              });
                            },
                            validator: (value) {
                              return value!.trim().isNotEmpty
                                  ? null
                                  : "Please enter your name";
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                        ),
                        const SizedBox(height: defaultPadding),
                        ListTile(
                          title: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              labelStyle: textLargeSize,
                              enabledBorder: UnderlineInputBorder(),
                            ),
                            initialValue: changedMerchant.phone,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              setState(() {
                                changedMerchant.phone = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          elevation: 0,
          child: ElevatedButton(
            onPressed: () {
              if (_profileFormKey.currentState!.validate()) {
                // TODO: Process data.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Processing Data'),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ),
      ),
    );
  }
}
