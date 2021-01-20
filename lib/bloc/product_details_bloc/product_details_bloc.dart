import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/error.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:try_neostore/repository/cart_repository.dart';
import 'package:try_neostore/repository/product_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
      
  final ProductRepository productRepository = ProductRepository();
  final CartRepository cartRepository = CartRepository();

  ProductDetailsBloc() : super(ProductDetailsInitial());

  @override
  Stream<ProductDetailsState> mapEventToState(
    ProductDetailsEvent event,
  ) async* {
    if (event is OnShowProductDetails) {
      yield ProductDetailsLoading();

      var response = await productRepository.productDetailsService(
          productId: event.productId.toString());

      if (response.statusCode == 200) {
        var productDetailsModel = productDetailsModelFromJson(response.data);

        yield ProductDetailsSuccessful(
            productDetailsModel: productDetailsModel);
      } else {
        yield ProductDetailsUnsuccessful();
      }
    }
//************************************************************************************** */
    if (event is OnBuyNowClicked) {
      yield ProductBuyNowLoading();

      var response = await cartRepository.addItemCartService(
          productId: event.productId,
          quantity: event.quantity,
          accessToken: event.accessToken);

      if (response.statusCode == 200) {
        var response = await productRepository.productDetailsService(
            productId: event.productId.toString());

        if (response.statusCode == 200) {
          var productDetailsModel = productDetailsModelFromJson(response.data);

          yield ProductBuyNowSuccessful(
              productDetailsModel: productDetailsModel);
        }
      } else {
        yield ProductBuyNowUnsuccessful();
      }
    }
//************************************************************************************** */
    if (event is OnRateButtonClicked) {
      yield ProductRatingLoading();

      var response = await productRepository.setProductRatingService(
          productId: event.productId.toString(), rating: event.feedbackRating);

      if (response.statusCode == 200) {
        var response =
            await productRepository. productDetailsService(productId: event.productId.toString());

        if (response.statusCode == 200) {
          var productDetailsModel = productDetailsModelFromJson(response.data);

          yield ProductRatingSuccessful(
              productDetailsModel: productDetailsModel);
        } else {
          var error = errorModelFromJson(response.data);
          yield ProductRatingUnsuccessful(error: error.userMsg);
        }
      }
    }
  }
}
