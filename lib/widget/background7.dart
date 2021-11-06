import 'package:flutter/material.dart';

class BackgroundImage7 extends StatelessWidget {
  const BackgroundImage7({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bac6.png'),
          fit: BoxFit.cover,

        ),
      ),
    );

  }
}