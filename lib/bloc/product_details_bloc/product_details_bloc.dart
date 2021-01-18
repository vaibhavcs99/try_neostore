import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial());

  @override
  Stream<ProductDetailsState> mapEventToState(
    ProductDetailsEvent event,
  ) async* {
    if (event is OnShowProductDetails) {
      yield ProductDetailsLoading();

      var response =
          await productDetailsService(productId: event.productId.toString());

      if (response.statusCode == 200) {
        var productDetailsModel = productDetailsModelFromJson(response.data);

        yield ProductDetailsSuccessful(
            productDetailsModel: productDetailsModel);
      } else {
        yield ProductDetailsUnsuccessful();
      }
    }

    if (event is OnBuyNowClicked) {
      yield ProductBuyNowLoading();

      var response = await addItemCartService(
          productId: event.productId,
          quantity: event.quantity,
          accessToken: event.accessToken);

      if (response.statusCode == 200) {
        yield ProductBuyNowSuccessful();
      } else {
        yield ProductBuyNowUnsuccessful();
      }
    }

    if (event is OnRateButtonClicked) {
      yield ProductRatingLoading();

      var response = await setProductRatingService(
          productId: event.productId.toString(), rating: event.feedbackRating);

      if (response.statusCode == 200) {
        var response =
            await productDetailsService(productId: event.productId.toString());

        if (response.statusCode == 200) {
          var productDetailsModel = productDetailsModelFromJson(response.data);
          yield ProductRatingSuccessful(
              productDetailsModel: productDetailsModel);
        } else {
          yield ProductRatingUnsuccessful();
        }
      }
    }
  }
}
