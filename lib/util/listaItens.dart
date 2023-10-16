import 'package:flutter/material.dart';

class listaitens extends StatelessWidget {
  final String item;
  final String iteminfo;
  final String itemvalue;
  const listaitens(
      {Key? key,
      required this.item,
      required this.iteminfo,
      required this.itemvalue})
      : super(key: key);
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              item,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              iteminfo,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            trailing: Text(itemvalue),
          ),
        ),
      ],
    );
  }
}
