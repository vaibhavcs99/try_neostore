import 'package:try_neostore/network/api_services.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/screens/common/my_drawer.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account')),
      drawer: Drawer(
        child: MyDrawer(widget._apiResponse),
      ),
      body: Center(
        child: FutureBuilder<FetchDataResponse>(
            future: getDetails(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print(snapshot.data);
                return CircularProgressIndicator();
              } else {
                var userData = snapshot.data.data.userData;
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${snapshot.data.data.productCategories[0].iconImage}'),
                    ),
                    Text(userData.firstName ?? 'no data'),
                    Text(userData.lastName ?? 'no data'),
                    Text(userData.email ?? 'no data'),
                    Text(userData.phoneNo ?? 'no data'),
                    Text(userData.dob ?? 'no data'),
                    FlatButton(
                        onPressed: () => Navigator.pushNamed(
                            context, route_edit_account_details,
                            arguments: widget._apiResponse),
                        child: Text('Edit Profile')),
                    FlatButton(
                      onPressed: () => Navigator.pushNamed(
                          context, route_change_password,
                          arguments: widget._apiResponse),
                      child: Text('Reset Password'),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  Future<FetchDataResponse> getDetails() async {
    dynamic _receivedDynamicResponse =
        await myAccountDetailsService(widget._apiResponse.data.accessToken);
    if (_receivedDynamicResponse is String) {
      print(_receivedDynamicResponse);
    } else if (_receivedDynamicResponse is FetchDataResponse) {
      // print(_receivedDynamicResponse.data.userData.email);
      return _receivedDynamicResponse;
    }
  }
  // Future<FetchDataResponse> getDetails() async {
  //   var dio = Dio();
  //   dio.options.headers['access_token'] = widget._apiResponse.data.accessToken;
  //   try {
  //     return await dio.get(urlFetchAccountDetails).then((value) {
  //       return fetchDataResponseFromJson(value.data);
  //     });
  //   } on DioError catch (dioError) {
  //     print('${dioError.error.toString()}');
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }
}
