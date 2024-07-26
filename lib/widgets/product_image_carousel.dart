import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:telo/constants.dart';

class ProductImageCarousel extends StatefulWidget {
  late List<String> imageList;

  late List<Widget> imageSliders;

  ProductImageCarousel(this.imageList) {
    imageSliders = _generateSlides();
  }

  List<Widget> _generateSlides() {
    return imageList
        .map((item) => Container(
        margin: EdgeInsets.all(4),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: CachedNetworkImage(
              imageUrl: HOST_URL + item,
              fit: BoxFit.cover,
              width: 1000,
              errorWidget: (context, url, error) =>
                  Icon(Icons.warning_rounded),
            ))))
        .toList();
  }

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
            items: widget.imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: false,
                aspectRatio: 1/1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageList.asMap().entries.map((e) {
                return GestureDetector(
                    onTap: () {
                      _controller.animateToPage(e.key);
                    },
                    child: Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PRIMARY_SWATCH
                              .withOpacity(_current == e.key ? 0.9 : 0.4)),
                    ));
              }).toList(),
            ))
      ],
    );
  }
}
