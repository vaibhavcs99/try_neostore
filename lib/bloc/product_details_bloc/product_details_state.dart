part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccessful extends ProductDetailsState {
  final ProductDetailsModel productDetailsModel;

  ProductDetailsSuccessful({@required this.productDetailsModel});
}

class ProductDetailsUnsuccessful extends ProductDetailsState {}

//************************************************************************
class ProductBuyNowLoading extends ProductDetailsState {}

class ProductBuyNowSuccessful extends ProductDetailsState {}

class ProductBuyNowUnsuccessful extends ProductDetailsState {}

//************************************************************************
class ProductRatingLoading extends ProductDetailsState {}

class ProductRatingSuccessful extends ProductDetailsState {
  final ProductDetailsModel productDetailsModel;

  ProductRatingSuccessful({@required this.productDetailsModel});
}

class ProductRatingUnsuccessful extends ProductDetailsState {
  final String error;

  ProductRatingUnsuccessful({@required this.error});
}
