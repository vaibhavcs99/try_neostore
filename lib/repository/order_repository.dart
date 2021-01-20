import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/constants/urls.dart';

class OrderRepository {
  static final OrderRepository _orderRepostiory =
      OrderRepository._private();

  factory OrderRepository() {
    return _orderRepostiory;
  }
  OrderRepository._private() {
    print('Order repository constructer generated');
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

}