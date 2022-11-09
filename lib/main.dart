import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: Colors.white,
        primaryColor: pinkHeavyColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: pinkLightColor,
            foregroundColor: Colors.black //here you can give the text color
            ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: greyBackground,
          iconColor: pinkColor,
          hintStyle: TextStyle(color: greyColor),
          prefixIconColor: greyColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          border: OutlineInputBorder(
            borderRadius: border,
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: pinkHeavyColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 50),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                elevation: 0, foregroundColor: Colors.black)),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: pinkColor),
        dividerTheme: const DividerThemeData(color: pinkColor, thickness: 2),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: greyBackground,
          actionTextColor: pinkHeavyColor,
        ),
      ),
      home: const Login(),
    );
  }
}
