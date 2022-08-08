import 'package:flutter/material.dart';

class Item_Box extends StatelessWidget {
  late Size size;
  final VoidCallback onpressed;
  String num;

  Item_Box({required this.size, required this.onpressed, required this.num});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        tileColor: Colors.greenAccent,
        leading: IconButton(
          onPressed: onpressed,
          icon: const Icon(
            Icons.highlight_remove,
            size: 35,
            color: Colors.blueGrey,
          ),
        ),
        trailing: Text(
          '$num',
          style: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }
}
