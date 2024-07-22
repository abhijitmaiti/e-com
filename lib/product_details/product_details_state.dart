import 'package:telo/models/product_detail_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  ProductDetailModel model;
  ProductDetailsLoaded(this.model);
}

class ProductDetailsFailed extends ProductDetailsState {
  String message;
  ProductDetailsFailed(this.message);
}
