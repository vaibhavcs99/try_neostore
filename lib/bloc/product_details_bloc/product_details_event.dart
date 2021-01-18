part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class OnShowProductDetails extends ProductDetailsEvent {
  final int productId;

  OnShowProductDetails({@required this.productId});
}

class OnBuyNowClicked extends ProductDetailsEvent {
  final int productId;
  final int quantity;
  final String accessToken;

  OnBuyNowClicked(
      {@required this.productId,
      @required this.quantity,
      @required this.accessToken});
}

class OnRateButtonClicked extends ProductDetailsEvent {
  final String productId;
  final double feedbackRating;
  OnRateButtonClicked({
    @required this.productId,
    @required this.feedbackRating,
  });
}
