import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telo/home/fragment/home_fragment/home_fragment_repository.dart';
import 'package:telo/home/fragment/home_fragment/home_fragment_state.dart';
import 'package:telo/models/category_model.dart';
import 'package:telo/models/slide_model.dart';

class HomeFragmentCubit extends Cubit<HomeFragmentState> {
  HomeFragmentCubit() : super(HomeFragmentInitial());
  HomeFragmentRepository _repository = HomeFragmentRepository();



  void loadCategories() {
    emit(HomeFragmentLoading());
    _repository.categories().then((response) {
      List<CategoryModel> categroies = List.from(
        response.data.map(
          (json) => CategoryModel.fromJson(json),
        ),
      );
      loadSlides(categroies);
    }).catchError((value) {
      DioException error = value;
      if (error.response != null) {
        try {
          emit(HomeFragmentFailed(error.response!.data));
        } catch (e) {
          emit(HomeFragmentFailed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioExceptionType.unknown) {
          emit(HomeFragmentFailed("Please check your internet connection"));
        } else {
          emit(HomeFragmentFailed(error.message ?? "error"));
        }
      }
    });
  }


  void loadSlides(categories) {
    _repository.slides().then((response) {
      emit(HomeFragmentLoaded(
          categories,
          List.from(
            response.data.map(
              (json) => SlideModel.fromJson(json),
            ),
          )));
    }).catchError((value) {
      DioException error = value;
      if (error.response != null) {
        try {
          emit(HomeFragmentFailed(error.response!.data));
        } catch (e) {
          emit(HomeFragmentFailed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioExceptionType.unknown) {
          emit(HomeFragmentFailed("Please check your internet connection"));
        } else {
          emit(HomeFragmentFailed(error.message ?? "error"));
        }
      }
    });
  }
}
