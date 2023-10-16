import 'package:flutter/material.dart';

class Emojis extends StatelessWidget {
  final String emojisitens;
  const Emojis({Key? key, required this.emojisitens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(
          emojisitens,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
