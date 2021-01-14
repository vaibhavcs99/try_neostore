import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/cart_list_model.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/model/order_details_model.dart';
import 'package:try_neostore/model/order_list_model.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:try_neostore/model/product_list_model.dart';

Future<dynamic> authenticateUserService(
    Map<String, dynamic> userDetails) async {
  Dio dio = Dio();

  FormData formData = FormData.fromMap(userDetails);
  try {
    var _receivedResponseFromServer = await dio.post(urlLogin, data: formData);
    if (_receivedResponseFromServer.statusCode == 200) {
      return _receivedResponseFromServer;
    }
  } on DioError catch (dioError) {
    // return dioError.response.statusCode.toString();
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<dynamic> registerUserService(Map<String, dynamic> userDetails) async {
  var dio = Dio();

  FormData formData = FormData.fromMap(userDetails);
  try {
    var _receivedResponseFromServer =
        await dio.post(urlRegister, data: formData);
    final sendResponseBack =
        apiResponseFromJson(_receivedResponseFromServer.data);
    return sendResponseBack;
  } on DioError catch (dioError) {
    print(dioError);
    return dioError.response.statusCode;
  } catch (e) {
    return '$e';
  }
}

Future<String> sendPasswordResetMailService(
    Map<String, dynamic> _userEmail) async {
  var dio = Dio();

  FormData formData = FormData.fromMap(_userEmail);

  try {
    await dio.post(urlForgotPassword, data: formData);
    return 'Password reset email is sent!';
  } on DioError catch (dioError) {
    if (dioError.response.statusCode == 404) return ('Email not found');
  } catch (e) {
    return 'Something is wrong!';
  }
  return 'Something is wrong!';
}

Future<String> changePasswordService(
    String receivedAccessToken, Map<String, dynamic> passwordDetails) async {
  var dio = Dio();

  dio.options.headers['access_token'] = receivedAccessToken;

  FormData _formData = FormData.fromMap(passwordDetails);

  try {
    await dio.post(urlChangePassword, data: _formData);
    return 'Password Changed';
  } on DioError catch (dioError) {
    return dioError.message;
  } catch (e) {
    return 'Something is wrong';
  }
}

Future<String> editAccountDetailsService(
    String receivedAccessToken, Map<String, dynamic> userDetails) async {
  var dio = Dio();

  dio.options.headers['access_token'] = receivedAccessToken;

  FormData formData = FormData.fromMap(userDetails);
  try {
    await dio.post(urlUpdateAccountDetails, data: formData);
    return 'Account Details Updated';
  } on DioError catch (dioError) {
    return dioError.response.statusMessage;
  } catch (e) {
    return 'Something is Wrong!';
  }
}

Future<dynamic> myAccountDetailsService(String receivedAccessToken) async {
  var dio = Dio();
  dio.options.headers['access_token'] = receivedAccessToken;
  try {
    var _responseFetchedFromServer = await dio.get(urlFetchAccountDetails);
    return fetchDataResponseFromJson(_responseFetchedFromServer.data);
  } on DioError catch (dioError) {
    return dioError.response.statusMessage;
  } catch (e) {
    return 'Something is wrong!';
  }
}

Future<ProductsListModel> productListService(String _productCategory) async {
  var dio = Dio();

  Map<String, dynamic> json = {
    'product_category_id': '$_productCategory',
  };

  try {
    var response = await dio.get(urlGetProductList, queryParameters: json);
    final productsListModel = productsListModelFromJson(response.data);
    return productsListModel;
  } on DioError catch (dioError) {
    print(dioError);
  } catch (e) {}
}

Future<ProductDetailsModel> productDetailsService(String _productId) async {
  var dio = Dio();

  Map<String, dynamic> json = {
    'product_id': '$_productId',
  };

  try {
    var response = await dio.get(urlGetProductDetails, queryParameters: json);
    final productsListModel = productDetailsModelFromJson(response.data);
    return productsListModel;
  } on DioError catch (dioError) {
    print(dioError);
  } catch (e) {}
}

Future<CartListModel> cartListService(
    {@required String receivedAccessToken}) async {
  var dio = Dio();
  dio.options.headers['access_token'] = receivedAccessToken;
  var data = await dio.get(urlListCartItems);
  final cartListModel = cartListModelFromJson(data.data);

  return cartListModel;
}

addItemCartService(
    {@required int myProductId,
    @required int quantity,
    @required String receivedAccessToken}) async {
  var dio = Dio();
  dio.options.headers['access_token'] = receivedAccessToken;

  Map<String, dynamic> productData = {
    'product_id': myProductId,
    'quantity': quantity
  };

  FormData formData = FormData.fromMap(productData);
  var response = await dio.post(urlAddToCart, data: formData);
  if (response.statusCode == 200) {
    return response;
  }
}

deleteItemCartService(
    {@required int myProductId, @required String receivedAccessToken}) async {
  var dio = Dio();
  dio.options.headers['access_token'] = receivedAccessToken;

  Map<String, dynamic> productData = {
    'product_id': myProductId,
  };

  FormData formData = FormData.fromMap(productData);

  await dio.post(urlDeleteCart, data: formData);
}

editItemCartService(
    {@required int myProductId,
    @required int quantity,
    @required String receivedAccessToken}) async {
  var dio = Dio();
  dio.options.headers['access_token'] = receivedAccessToken;

  Map<String, dynamic> productData = {
    'product_id': myProductId,
    'quantity': quantity
  };

  FormData formData = FormData.fromMap(productData);

  var data = await dio.post(urlEditCart, data: formData);
}

orderItemsService(
    {@required String address, @required String myAccessToken}) async {
  var dio = Dio();

  dio.options.headers['access_token'] = myAccessToken;
  Map<String, dynamic> parameters = {'address': address};
  FormData formData = FormData.fromMap(parameters);

  var response = await dio.post(urlOrder, data: formData);

  return response.statusCode;
}

Future<OrderListModel> orderListService(
    {@required String myAccessToken}) async {
  var dio = Dio();

  dio.options.headers['access_token'] = myAccessToken;

  var orderListJson = await dio.get(urlOrderList);
  final orderListModel = orderListModelFromJson(orderListJson.data);
  return orderListModel;
}

Future<OrderDetailsModel> orderDetailsService(
    {@required String myAccessToken, @required int orderId}) async {
  var dio = Dio();
  dio.options.headers['access_token'] = myAccessToken;

  Map<String, dynamic> parameters = {'order_id': orderId};
  // FormData formData = FormData.fromMap(parameters);

  var response = await dio.get(urlOrderDetail, queryParameters: parameters);
  final orderDetailsModel = orderDetailsModelFromJson(response.data);

  return orderDetailsModel;
}

setProductRatingService(
    {@required String productId, @required double rating}) async {
  var dio = Dio();
  Map<String, dynamic> parameters = {'product_id': productId, 'rating': rating};
  FormData formData = FormData.fromMap(parameters);

  try {
    var data = await dio.post(urlSetProductRating, data: formData);
    print(data.data);
  } on DioError catch (dioError) {
    print(dioError.response.data);
  }
}
