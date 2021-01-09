import 'package:dio/dio.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';

Future<dynamic> authenticateUserService(
    Map<String, dynamic> userDetails) async {
  Dio dio = Dio();

  FormData formData = FormData.fromMap(userDetails);
  try {
    var _receivedResponseFromServer = await dio.post(urlLogin, data: formData);
    if (_receivedResponseFromServer.statusCode == 200) {
      return apiResponseFromJson(_receivedResponseFromServer.data);
    }
  } on DioError catch (dioError) {
        // return dioError.response.statusCode.toString();
    return 'Invalid Credentials';
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
