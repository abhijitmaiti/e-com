import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telo/constants.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ratings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 18),
        Row(

          children: [
            Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("4.5",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.star, size: 34, color: Colors.amber)
            ])),
            Expanded(
                child: Column(

              children: [
                _ratingProgress("5", 0.5, Colors.green, 10),
                _ratingProgress("4", 0.5, Colors.lightGreenAccent, 10),
                _ratingProgress("5", 0.5, Colors.lightGreen, 10),
                _ratingProgress("2", 0.5, Colors.yellow, 10),
                _ratingProgress("1", 0.5, Colors.red, 10),
                Divider(),
                Text("total ratings")
              ],
            ))
          ],
        )
      ],
    );
  }

  _ratingProgress(title, progress, color, count) {
    return Row(
      children: [
        Text(title + ' ', style: TextStyle(fontSize: 12, height: 1.8)),
        Icon(Icons.star, size: 12),
        SizedBox(width: 8),
        Expanded(
            child: LinearProgressIndicator(
                value: progress,
                valueColor: AlwaysStoppedAnimation<Color>(color))),
        SizedBox(width: 8),
        Text(count.toString(), style: TextStyle(fontSize: 12, height: 1.8)),
      ],
    );
  }
}
