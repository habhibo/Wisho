import 'package:flutter/material.dart';

class BackgroundImage4 extends StatelessWidget {
  const BackgroundImage4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ba4c.png'),
          fit: BoxFit.cover,

        ),
      ),
    );

  }
}