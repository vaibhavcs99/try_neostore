import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/constants/urls.dart';

Future<Response> authenticateUserService(String email, String password) async {
  Dio dio = Dio();

  Map<String, dynamic> userDetails = {'email': email, 'password': password};

  FormData formData = FormData.fromMap(userDetails);
  try {
    var response = await dio.post(urlLogin, data: formData);
    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<Response> registerUserService(
    {@required Map<String, dynamic> userDetails}) async {
  var dio = Dio();

  FormData formData = FormData.fromMap(userDetails);
  try {
    var response = await dio.post(urlRegister, data: formData);

    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<Response> sendPasswordResetMailService(
    Map<String, dynamic> _userEmail) async {
  var dio = Dio();

  FormData formData = FormData.fromMap(_userEmail);

  try {
    var response = await dio.post(urlForgotPassword, data: formData);
    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<Response> changePasswordService({
  String accessToken,
  @required String currentPassword,
  @required String newPassword,
  @required String confirmNewPassword,
}) async {
  Map<String, dynamic> passwordDetails = {
    'old_password': currentPassword,
    'password': newPassword,
    'confirm_password': confirmNewPassword,
  };
  var dio = Dio();

  dio.options.headers['access_token'] = accessToken;

  FormData _formData = FormData.fromMap(passwordDetails);

  try {
    var response = await dio.post(urlChangePassword, data: _formData);
    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<Response> editAccountDetailsService(
    String accessToken, Map<String, dynamic> userDetails) async {
  var dio = Dio();

  dio.options.headers['access_token'] = accessToken;

  FormData formData = FormData.fromMap(userDetails);
  try {
    var response = await dio.post(urlUpdateAccountDetails, data: formData);
    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<Response> myAccountDetailsService(String accessToken) async {
  var dio = Dio();
  dio.options.headers['access_token'] = accessToken;
  try {
    var response = await dio.get(urlFetchAccountDetails);
    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
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

Future<Response> orderItemsService(
    {@required String address, @required String accessToken}) async {
  var dio = Dio();

  dio.options.headers['access_token'] = accessToken;
  Map<String, dynamic> parameters = {'address': address};
  FormData formData = FormData.fromMap(parameters);

  try {
    var response = await dio.post(urlOrder, data: formData);
    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<Response> orderListService({@required String accessToken}) async {
  var dio = Dio();

  dio.options.headers['access_token'] = accessToken;

  try {
    var response = await dio.get(urlOrderList);
    return response;
  } on DioError catch (dioError) {
    return dioError.response;
  } catch (error) {
    print(error);
  }
}

Future<Response> orderDetailsService(
    {@required String accessToken, @required int orderId}) async {
  var dio = Dio();
  dio.options.headers['access_token'] = accessToken;

  Map<String, dynamic> parameters = {'order_id': orderId};
  // FormData formData = FormData.fromMap(parameters);

  try {
    var response = await dio.get(urlOrderDetail, queryParameters: parameters);
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
  Map<String, dynamic> parameters = {'product_id': productId, 'rating': rating};
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
