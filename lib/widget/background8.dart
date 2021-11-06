import 'package:flutter/material.dart';

class BackgroundImage8 extends StatelessWidget {
  const BackgroundImage8({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bac7.png'),
          fit: BoxFit.cover,

        ),
      ),
    );

  }
}