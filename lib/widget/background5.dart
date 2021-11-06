import 'package:flutter/material.dart';

class BackgroundImage5 extends StatelessWidget {
  const BackgroundImage5({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bac4.png'),
          fit: BoxFit.cover,

        ),
      ),
    );

  }
}