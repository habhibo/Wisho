import 'package:flutter/material.dart';

class BackgroundImage0 extends StatelessWidget {
  const BackgroundImage0({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bac0.png'),
          fit: BoxFit.cover,

        ),
      ),
    );

  }
}