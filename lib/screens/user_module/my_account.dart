import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/screens/widgets/container_white_border.dart';
import 'package:try_neostore/screens/widgets/my_drawer.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';
import 'package:try_neostore/bloc/my_account_bloc/my_account_bloc.dart';

class MyAccountDetails extends StatefulWidget {
  final String accessToken;

  const MyAccountDetails({Key key, this.accessToken}) : super(key: key);
  @override
  _MyAccountDetailsState createState() => _MyAccountDetailsState();
}

class _MyAccountDetailsState extends State<MyAccountDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MyAccountBloc>(context).add(OnShowAccountDetails(accessToken: widget.accessToken));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: primaryRed2,
        appBar: AppBar(title: Text('My Account')),
        drawer: Drawer(
          child: MyDrawer(
            accessToken: widget.accessToken,
          ),
        ),
        body: Center(
          child: BlocBuilder<MyAccountBloc, MyAccountState>(
            builder: (context, state) {
              if (state is MyAccountSuccessful) {
                var userData = state.fetchDataResponse.data.userData;
                return buildAccountScreen(userData, context);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  ListView buildAccountScreen(UserData userData, BuildContext context) {
    return ListView(
      children: [
        CircleAvatar(
          radius: 66,
          backgroundImage:
              NetworkImage('https://cdn.wallpapersafari.com/91/96/D8ZYbS.jpg'),
        ),
        BorderContainer(
            myText: userData.firstName,
            myIcon: Icon(Icons.person, color: Colors.white)),
        BorderContainer(
            myText: userData.lastName,
            myIcon: Icon(Icons.person, color: Colors.white)),
        BorderContainer(
            myText: userData.email,
            myIcon: Icon(Icons.mail, color: Colors.white)),
        BorderContainer(
            myText: userData.phoneNo,
            myIcon: Icon(Icons.phone_android, color: Colors.white)),
        BorderContainer(
            myText: userData.dob,
            myIcon: Icon(Icons.cake, color: Colors.white)),
        MyButton(
          onPressed: () => Navigator.pushNamed(
              context, route_edit_account_details,
              arguments: widget.accessToken),
          myText: 'Edit Profile',
        ),
        FlatButton(
          color: Colors.white,
          minWidth: double.infinity,
          height: 9.0.h,
          onPressed: () => Navigator.pushNamed(context, route_change_password,
              arguments: widget.accessToken),
          child: Text('RESET PASSWORD',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 21,
                  fontWeight: FontWeight.w500)),
        )
      ],
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you Sure?'),
          content: Text('Do you want to exit an App?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No')),
          ],
        );
      },
    );
  }
}
