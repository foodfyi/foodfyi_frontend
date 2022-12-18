import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/pages/menu/main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  bool isChecked = true;

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _email.text = 'jjmember@gmail.com';
      _pwd.text = '123456';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                return value!.trim().isNotEmpty
                    ? null
                    : "Please enter your email";
              },
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: _pwd,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.password),
              ),
              validator: (value) {
                return value!.trim().isNotEmpty
                    ? null
                    : "Please enter your password";
              },
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    value: isChecked,
                  ),
                  const Text('Remember Me'),
                  const Spacer(),
                  TextButton(
                    onPressed: (() {}),
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MenuMain();
                        },
                      ),
                    );
                  }
                },
                child: const Text('Sign In'),
              ),
            ),
            const SizedBox(height: defaultPadding),
            const Text.rich(
              TextSpan(
                text:
                    'Please contact us if you don\'t have a merchant account ',
                children: [
                  TextSpan(
                    text: 'foodfyicu@columbia.edu',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
