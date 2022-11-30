import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/merchant.dart';
import 'package:foodfyi/pages/login/login.dart';
import 'package:foodfyi/pages/profile/profile.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  Merchant merchant = mockMerchant;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: pinkLightColor,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding * 2),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      merchant.avatar == ''
                          ? "assets/images/merchant-member.png"
                          : merchant.avatar!,
                      width: imgWidth,
                    ),
                  ),
                  const SizedBox(height: 0.5 * defaultPadding),
                  Text(merchant.email),
                  const SizedBox(height: 0.5 * defaultPadding),
                  TextButton(
                    onPressed: (() async {
                      Merchant? changedMerchant = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            merchant: merchant,
                          ),
                        ),
                      );
                      if (changedMerchant != null) {
                        setState(() {
                          merchant = changedMerchant;
                        });
                      }
                    }),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text(merchant.name),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.storefront_outlined),
              title: Text(merchant.merchantName),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: Text(merchant.phone!),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sign Out"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Login();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
