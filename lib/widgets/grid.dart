
import 'package:flutter/material.dart';
import 'package:telo/models/pageitem_model.dart';
import 'package:telo/widgets/product_display.dart';

class Grid extends StatelessWidget {
  late Result result;
  Grid(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    int productCount = result.productOptions!.length;
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                result.title!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(onPressed: () {}, child: Text('view all'))
            ],
          ),
          IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductDisplay(result.productOptions![0], null),
                  if (productCount > 1) ...[
                    VerticalDivider(
                      thickness: 1,
                        color: Colors.grey.shade300,
                    ),
                    ProductDisplay(result.productOptions![1], null),
                  ]
                ]),
          ),
          if (productCount > 2) ...[
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProductDisplay(result.productOptions![2], null),
                    if (productCount > 3) ...[
                      VerticalDivider(
                        thickness: 1,
                          color: Colors.grey.shade300
                      ),
                      ProductDisplay(result.productOptions![3], null),
                    ]
                  ]),
            ),
          ]
        ],
      ),
    );
  }
}
