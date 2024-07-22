import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telo/models/product_detail_model.dart';
import 'package:telo/product_details/product_details_repository.dart';
import 'package:telo/product_details/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productId) : super(ProductDetailsInitial()) {
    loadDetails();
  }
  String productId;
  ProductDetailsRepository _repository = ProductDetailsRepository();

  void loadDetails() {
    emit(ProductDetailsLoading());
    _repository.loadDetails(productId).then((response) {
      emit(ProductDetailsLoaded(ProductDetailModel.fromJson(response.data)));
    }).catchError((value) {
      DioException error = value;
      if (error.response != null) {
        try {
          emit(ProductDetailsFailed(error.response!.data));
        } catch (e) {
          emit(ProductDetailsFailed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioExceptionType.unknown) {
          emit(ProductDetailsFailed("Please check your internet connection"));
        } else {
          emit(ProductDetailsFailed(error.message ?? "error"));
        }
      }
    });
  }
}
