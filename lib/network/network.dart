import 'package:dio/dio.dart';
import 'package:try_neostore/constants/urls.dart';

getDetails() async {
  var dio = Dio();
  await dio.put(urlFetchAccountDetails);
}
