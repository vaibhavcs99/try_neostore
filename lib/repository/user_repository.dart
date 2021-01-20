import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/constants/urls.dart';

class UserRepository {
  static final UserRepository _userRepostiory = UserRepository._internal();

  factory UserRepository() {
    return _userRepostiory;
  }
  UserRepository._internal(){
    print('User repository constructer generated');
  }

  Future<Response> authenticateUserService(
      String email, String password) async {
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

  Future<Response> editAccountDetailsService({
    @required String accessToken,
    @required Map<String, dynamic> userDetails,
  }) async {
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
}
