import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodfyi/constants.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
            flex: 8,
            child: SvgPicture.asset(
              "assets/svgs/logo.svg",
              height: logoHeight,
              width: logoWidth,
              fit: BoxFit.scaleDown,
            )),
        const Spacer(),
      ],
    );
  }
}
