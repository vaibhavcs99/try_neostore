import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/urls.dart';

class ProductRepository {
  static final ProductRepository _productRepostiory =
      ProductRepository._private();

  factory ProductRepository() {
    return _productRepostiory;
  }
  ProductRepository._private() {
    print('Product repository constructer generated');
  }

  Future<Response> productListService(
      {@required String productCategoryId}) async {
    var dio = Dio();

    Map<String, dynamic> json = {
      'product_category_id': '$productCategoryId',
    };

    try {
      var response = await dio.get(urlGetProductList, queryParameters: json);
      return response;
    } on DioError catch (dioError) {
      return dioError.response;
    } catch (error) {
      print(error);
    }
  }

  Future<Response> productDetailsService({@required String productId}) async {
    var dio = Dio();

    Map<String, dynamic> json = {
      'product_id': '$productId',
    };

    try {
      var response = await dio.get(urlGetProductDetails, queryParameters: json);
      return response;
    } on DioError catch (dioError) {
      return dioError.response;
    } catch (error) {
      print(error);
    }
  }

  Future<Response> setProductRatingService(
      {@required String productId, @required double rating}) async {
    var dio = Dio();
    Map<String, dynamic> parameters = {
      'product_id': productId,
      'rating': rating
    };
    FormData formData = FormData.fromMap(parameters);

    try {
      var response = await dio.post(urlSetProductRating, data: formData);
      return response;
    } on DioError catch (dioError) {
      return dioError.response;
    } catch (error) {
      print(error);
    }
  }
}
