import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telo/product_details/product_details_cubit.dart';
import 'package:telo/product_details/product_details_state.dart';

import '../widgets/product_image_carousel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Product details"),
        ),
        body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageCarousel(state.model.options![0].images!
                          .map((image) => image.image!)
                          .toList()),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.model.title!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Rs." + state.model.offerPrice!.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "Rs." + state.model.price!.toString(),
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text("Otions"),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),

                              style: const TextStyle(color: Colors.blue),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: <String>[
                                'One',
                                'Two',
                                'Three',
                                'Four'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(state.model.description!),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
            listener: (context, state) {}));
  }
}
