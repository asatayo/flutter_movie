import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Ratings extends StatelessWidget {
  double? ratings = 0;
  Ratings({Key? key, this.ratings}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int valueValue = (ratings! / 2).round();
    switch (valueValue) {
      case 1:
        return Row(
            children: const [Icon(Icons.star, size: 12, color: Colors.amber)]);
      case 2:
        return Row(children: const [
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
        ]);
      case 3:
        return Row(children: const [
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
        ]);
      case 4:
        return Row(children: const [
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
        ]);

      case 5:
        return Row(children: const [
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
        ]);
      default:
        return Row(children: const [
          SizedBox(
            height: 12,
          )
        ]);
    }
  }
}
