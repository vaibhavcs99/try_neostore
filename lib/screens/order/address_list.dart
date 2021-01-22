import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/bloc/address_list_bloc/address_list_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/repository/db_helper.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';
import 'package:sizer/sizer.dart';

class AddressList extends StatefulWidget {
  final String accessToken;
  const AddressList({
    Key key,
    this.accessToken,
  }) : super(key: key);
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var maxLimit = 0;

  var selectedAddress;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressListBloc>(context).add(OnShowAddressList());

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Address List'),
          actions: [buildAddAddressIcon(), SizedBox(width: 2.0.w)]),
      body: BlocListener<AddressListBloc, AddressListState>(
        listener: (context, state) async {
          if (state is PlaceOrderSuccessful) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Order Placed Successfully')));

            await Future.delayed(Duration(seconds: 3));

            Navigator.pushNamedAndRemoveUntil(
                context, route_home_screen, (route) => false,
                arguments: widget.accessToken);
          }

          if (state is DeleteAddressSuccessful) {
            maxLimit = state.addressList.length;
            print(maxLimit);
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Address Deleted Successfully')));
          }
          if (state is ShowAddressSuccessful) {
            maxLimit = state.addressList.length;
          }
        },
        child: ListView(
          children: [
            SizedBox(height: 3.0.h),
            buildAddressList(context),
            buildOrderButton(context),
          ],
        ),
      ),
    );
  }

  MyButton buildOrderButton(BuildContext context) {
    if (selectedAddress == null)
      return MyButton(
        myText: 'Place Order',
        onPressed: () => print('pressed'),
        color: Colors.grey,
        textColor: Colors.white,
      );
    return MyButton(
      onPressed: () {
        BlocProvider.of<AddressListBloc>(context).add(OnPlaceOrderPressed(
            address: selectedAddress, accessToken: widget.accessToken));
      },
      myText: 'Place Order',
      color: primaryRed2,
      textColor: Colors.white,
    );
  }

  Widget buildAddAddressIcon() {
    if (maxLimit < 4)
      return InkWell(
        child: Icon(Icons.add, size: 28.0.sp),
        onTap: () {
          Navigator.pushNamed(
            context,
            route_enter_address,
            arguments: widget.accessToken,
          );
        },
      );
    return SizedBox();
  }

  SizedBox buildAddressList(BuildContext context) {
    return SizedBox(
        height: 70.0.h,
        child: BlocBuilder<AddressListBloc, AddressListState>(
          builder: (context, state) {
            if (state is ShowAddressSuccessful) {
              var addressList = state.addressList;
              return buildAddressListView(addressList);
            }
            if (state is DeleteAddressSuccessful) {
              var addressList = state.addressList;
              return buildAddressListView(addressList);
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  ListView buildAddressListView(List<Map<String, dynamic>> addressList) {
    return ListView.builder(
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        var address = addressList[index];

        String addressName = address[DatabaseHelper.columnAddress];

        int addressId = address[DatabaseHelper.columnId];

        return buildAddressListTile(addressName, context, addressId);
      },
    );
  }

  Widget buildAddressListTile(
      String addressName, BuildContext context, int addressId) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 1.0.h),
      child: Card(
        child: ListTile(
            title: Text(addressName),
            trailing: InkWell(
                onTap: () => BlocProvider.of<AddressListBloc>(context)
                    .add(OnDeleteAddressPressed(id: addressId)),
                child: Icon(Icons.delete)),
            leading: Radio(
              value: addressName,
              groupValue: selectedAddress,
              onChanged: (value) {
                setState(() {
                  selectedAddress = value;
                  print(selectedAddress);
                });
              },
            )),
      ),
    );
  }
}
