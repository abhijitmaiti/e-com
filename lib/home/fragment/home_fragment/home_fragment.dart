import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telo/constants.dart';
import 'package:telo/home/fragment/home_fragment/home_fragment_cubit.dart';
import 'package:telo/home/fragment/home_fragment/home_fragment_state.dart';
import 'package:telo/models/pageitem_model.dart';
import 'package:telo/models/slide_model.dart';
import 'package:telo/pageitem/pageitem_cubit.dart';
import 'package:telo/pageitem/pageitem_state.dart';
import 'package:telo/widgets/category_item.dart';
import 'package:telo/widgets/grid.dart';
import 'package:telo/widgets/slider_carousel.dart';
import 'package:telo/widgets/swiper.dart';
import 'package:telo/widgets/banner.dart';

class HomeFragment extends StatelessWidget {
  var slides;
  List<Result>? pgItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeFragmentCubit, HomeFragmentState>(
          listener: (context, state) {
        if (state is HomeFragmentLoaded) {
          BlocProvider.of<PageItemCubit>(context)
              .loadItems(state.categories[0].id);
        }
        if (state is HomeFragmentFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ));
                    }
         
      }, builder: (context, state) {
        if (state is HomeFragmentInitial) {
          BlocProvider.of<HomeFragmentCubit>(context).loadCategories();
        }
        if (state is HomeFragmentLoaded) {
          slides = state.slides;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                toolbarHeight: 150,
                titleSpacing: 0,
                backgroundColor: Colors.white,
                title: Column(
                  children: [
                    Container(
                      color: PRIMARY_SWATCH,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                elevation: MaterialStateProperty.all(0)),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'Search',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 80,
                      child: _categories(state),
                    )
                  ],
                ),
              ),
              BlocConsumer<PageItemCubit, PageItemsState>(
                listener: (context, pgstate) {
                  if (pgstate is PageItemsFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(pgstate.message),
                        backgroundColor: Colors.red,
                      ));
                    }
                },
                builder: (context, pgstate) {
                  if (pgstate is PageItemsLoaded) {
                    pgItems!.clear();
                    pgItems!.add(Result(viewtype: 0));
                    pgItems!.addAll(pgstate.pageItemModel.results);
                  }

                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // return listItem(0);
                      if (index < pgItems!.length) {
                        return listItem(pgItems![index]);
                      } else {
                        if (pgstate is PageItemsLoaded &&
                            pgstate.pageItemModel.next != null) {
                          BlocProvider.of<PageItemCubit>(context)
                              .loadMoreItems();
                        }
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                    childCount: pgstate is PageItemsLoading ||
                            (pgstate is PageItemsLoaded &&
                                pgstate.pageItemModel.next != null)
                        ? pgItems!.length + 1
                        : pgItems!.length,
                  ));
                },
              )
            ],
          );
        }
        return CircularProgressIndicator();
      }),
    );
  }

  _categories(state) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.categories.length,
        itemBuilder: (_, index) {
          return CategoryItem(state.categories[index]);
        });
  }

  listItem(Result result) {
    switch (result.viewtype) {
      case 0:
        return SliderCarousel(List.from(slides.map((SlideModel slide) {
          return slide.image.toString();
        })));
      case 1:
        return result.image != null ? ImageBanner(DOMAIN_URL + result.image!) : Container();
      case 2:
        return Swiper(result);
      case 3:
        return Grid(result);

      default:
        return Text('error');
    }
  }
}
