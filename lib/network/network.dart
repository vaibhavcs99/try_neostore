import 'package:dio/dio.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';

Future<dynamic> authenticateUserService(
    Map<String, dynamic> userDetails) async {
  Dio dio = Dio();

  FormData formData = FormData.fromMap(userDetails);
  try {
    var _receivedResponseFromServer = await dio.post(urlLogin, data: formData);
    final sendResponseBack =
        apiResponseFromJson(_receivedResponseFromServer.data);
    return sendResponseBack;
  } catch (error) {
    return 'Invalid Credentials';
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
}
