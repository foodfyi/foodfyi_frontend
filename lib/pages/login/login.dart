import 'package:flutter/material.dart';
import 'package:foodfyi/pages/login/components/login_form.dart';
import 'package:foodfyi/pages/utils/center_background.dart';
import 'package:foodfyi/pages/utils/logo.dart';
import 'package:foodfyi/constants.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CenterBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Logo(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  'FOOD.FYI@CU',
                  style: logoTitleFont,
                ),
              ),
              const SizedBox(height: 3 * defaultPadding),
              Row(
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: LoginForm(),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
