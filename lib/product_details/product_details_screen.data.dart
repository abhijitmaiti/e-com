import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telo/product_details/product_details_cubit.dart';
import 'package:telo/product_details/product_details_state.dart';
import 'package:telo/widgets/product_rating.dart';

import '../models/product_detail_model.dart';
import '../widgets/product_image_carousel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // List<String> list = <String>['One', 'Two', 'Three', 'Four'];

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

  late String dropdownValue = ' ' ;
  Options? selectedOptions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsLoaded) {
                if(dropdownValue.isEmpty){
                  dropdownValue = state.model.options![0].id!;
                }
                return SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       AppBar(
                        title: Text("Product details"),
                         foregroundColor: Colors.black,
                         backgroundColor: Colors.transparent,
                           elevation: 0,
                           actions:
                            [
                           IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                           IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
                           ],

                      ),
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
                              items: state.model.options!
                                  .map<DropdownMenuItem<String>>((Options option) {
                                return DropdownMenuItem<String>(
                                  value: option.id,
                                  child: Text(option.option!),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(state.model.description!),
                            SizedBox(height: 16),

                            ProductRating(),

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
