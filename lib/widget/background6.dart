import 'package:flutter/material.dart';

class BackgroundImage6 extends StatelessWidget {
  const BackgroundImage6({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bac5.png'),
          fit: BoxFit.cover,

        ),
      ),
    );

  }
}