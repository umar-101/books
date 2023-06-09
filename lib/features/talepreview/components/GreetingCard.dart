import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 200),
      child: Text('Welcome'.tr().toString(),
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              decorationColor: Colors.pinkAccent,
              decorationStyle: TextDecorationStyle.wavy,
              fontSize: 40)),
    );
  }
}
