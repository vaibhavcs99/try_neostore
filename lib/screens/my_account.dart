import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';

class MyAccountDetails extends StatefulWidget {
  final ApiResponse _apiResponse;

  const MyAccountDetails(
    this._apiResponse, {
    Key key,
  }) : super(key: key);
  @override
  _MyAccountDetailsState createState() => _MyAccountDetailsState();
}

class _MyAccountDetailsState extends State<MyAccountDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var user = widget._apiResponse;
    return Scaffold(
      appBar: AppBar(title: Text('My Account')),
      body: Center(
        child: FutureBuilder<FetchDataResponse>(
            future: getDetails(),
            builder: (context, snapshot) {
              var userData = snapshot.data.data.userData;
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage('${snapshot.data.data.productCategories[0].iconImage}'),),
                  Text(userData.firstName ?? 'no data'),
                  Text(userData.lastName ?? 'no data'),
                  Text(userData.email ?? 'no data'),
                  Text(userData.phoneNo ?? 'no data'),
                  Text(userData.dob ?? 'no data'),
                  FlatButton(onPressed: null, child: Text('Edit Profile')),
                  FlatButton(onPressed: null,child: Text('Reset Password'),)
                ],
              );
            }),
      ),
    );
  }

  Future<FetchDataResponse> getDetails() async {
    var dio = Dio();
    dio.options.headers['access_token'] = '5ff679991c4b1';
    try {
      return await dio.get(urlFetchAccountDetails).then((value) {
        print('$value' + '**************');
        return fetchDataResponseFromJson(value.data);
      });
    } on DioError catch (dioError) {
      print('${dioError.error.toString()}' + '&&&&&&&&&&&&&&');
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
