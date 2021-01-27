import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/urls.dart';

class CartRepository {
  static final CartRepository _cartRepostiory = CartRepository._private();

  factory CartRepository() {
    return _cartRepostiory;
  }
  CartRepository._private() {
    print('Cart repository constructer generated');
  }

  Future<Response> cartListService({@required String accessToken}) async {
    var dio = Dio();
    dio.options.headers['access_token'] = accessToken;
    try {
      var response = await dio.get(urlListCartItems);
      return response;
    } on DioError catch (dioError) {
      return dioError.response;
    } catch (error) {
      print(error);
    }
  }

  Future<Response> addItemCartService(
      {@required int productId,
      @required int quantity,
      @required String accessToken}) async {
    var dio = Dio();
    dio.options.headers['access_token'] = accessToken;

    Map<String, dynamic> productData = {
      'product_id': productId,
      'quantity': quantity
    };

    FormData formData = FormData.fromMap(productData);
    try {
      var response = await dio.post(urlAddToCart, data: formData);
      return response;
    } on DioError catch (dioError) {
      return dioError.response;
    } catch (error) {
      print(error);
    }
  }

  Future<Response> deleteItemCartService(
      {@required int productId, @required String accessToken}) async {
    var dio = Dio();
    dio.options.headers['access_token'] = accessToken;

    Map<String, dynamic> productData = {
      'product_id': productId,
    };

    FormData formData = FormData.fromMap(productData);

    try {
      var response = await dio.post(urlDeleteCart, data: formData);
      return response;
    } on DioError catch (dioError) {
      return dioError.response;
    } catch (error) {
      print(error);
    }
  }

  Future<Response> editItemCartService(
      {@required int productId,
      @required int quantity,
      @required String accessToken}) async {
    var dio = Dio();
    dio.options.headers['access_token'] = accessToken;

    Map<String, dynamic> productData = {
      'product_id': productId,
      'quantity': quantity
    };

    FormData formData = FormData.fromMap(productData);

    try {
      var response = await dio.post(urlEditCart, data: formData);
      return response;
    } on DioError catch (dioError) {
      return dioError.response;
    } catch (error) {
      print(error);
    }
  }
}
