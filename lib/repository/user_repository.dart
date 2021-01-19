import 'package:dio/dio.dart';
import 'package:try_neostore/constants/urls.dart';

class UserRepository {
  static final UserRepository _userRepostiory = UserRepository._internal();

  factory UserRepository() {
    return _userRepostiory;
  }
  UserRepository._internal(){
    print('constructed generated');
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
}
