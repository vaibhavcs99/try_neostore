import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial());

  @override
  Stream<ProductListState> mapEventToState(
    ProductListEvent event,
  ) async* {
    if (event is ShowProductList) {
      yield ProductListLoading();
      var response =
          await productListService(productCategoryId: event.productCategoryId);

      if (response.statusCode == 200) {
        var productsListModel = productsListModelFromJson(response.data);

        yield ProductListSuccessful(productsListModel: productsListModel);
      }
    }
  }
}
