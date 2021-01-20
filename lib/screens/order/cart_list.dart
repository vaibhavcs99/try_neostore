import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:try_neostore/constants/constants.dart';

import 'package:try_neostore/model/cart_list_model.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';

class CartList extends StatefulWidget {
  final String accessToken;

  const CartList({Key key, @required this.accessToken}) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List itemList = <int>[1, 2, 3, 4, 5, 6, 7, 8];
  int dropDownValue = 1;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartListBloc>(context)
        .add(OnShowCartList(accessToken: widget.accessToken));
    return Scaffold(
        appBar: AppBar(
            title:
                Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold))),
        body:
            BlocBuilder<CartListBloc, CartListState>(builder: (context, state) {
          print(state.toString());
          if (state is CartListSuccessful) {
            return buildCartScreen(context, state);
          }
          if (state is CartDeleteItemSuccessful) {
            return buildCartScreen(context, state);
          }
          if (state is CartEditSuccessful) {
            return buildCartScreen(context, state);
          }

          return Center(child: CircularProgressIndicator());
        }));
  }

  Widget buildCartScreen(BuildContext context, state) {
    if (state.cartListModel.count == null)
      return Center(child: Text('Cart is empty!'));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.0.h),
      child: Column(
        children: [
          SizedBox(height: 1.0.h),
          buildListTile(context, state),
          SizedBox(height: 2.0.h),
          buildTotalPrice(state.cartListModel.total),
          buildOrderButton(context)
        ],
      ),
    );
  }

  SizedBox buildListTile(BuildContext context, state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.59,
      child: ListView(
        children: [
          SizedBox(
            height: 60.0.h,
            child: ListView.builder(
                itemCount: state.cartListModel.count,
                itemBuilder: (context, index) {
                  var productData = state.cartListModel.data[index];

                  return Dismissible(
                    key: Key(productData.product.id.toString()),
                    background: slideLeftBackground(),
                    onDismissed: (direction) {
                      BlocProvider.of<CartListBloc>(context).add(OnDeleteSwiped(
                          productId: productData.product.id,
                          accessToken: widget.accessToken));
                    },
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildProductImage(productData),
                          SizedBox(
                            width: 4.0.w,
                          ),
                          Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.0.h),
                                Text(productData.product.name,
                                    style: TextStyle(fontSize: 16.0.sp)),
                                SizedBox(height: 2.0.h),
                                Text(productData.product.productCategory),
                                buildDropdownButton(productData, context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  );
                }),
          ),
        ],
      ),
    );
  }

  DropdownButton<int> buildDropdownButton(
      Datum productData, BuildContext context) {
    return DropdownButton<int>(
      iconEnabledColor: Colors.black,
      value: productData.quantity,
      items: itemList
          .map((number) =>
              DropdownMenuItem<int>(value: number, child: Text('$number')))
          .toList(),
      onChanged: (value) {
        BlocProvider.of<CartListBloc>(context).add(OnDropDownPressed(
            productId: productData.product.id,
            quantity: value,
            accessToken: widget.accessToken));
        setState(() {});
      },
    );
  }

  MyButton buildOrderButton(BuildContext context) {
    return MyButton(
      color: primaryRed2,
      onPressed: () => Navigator.pushNamed(context, route_enter_address,
          arguments: widget.accessToken),
      myText: 'Order Now',
      textColor: Colors.white,
    );
  }

  Card buildTotalPrice(int totalPrice) {
    return Card(
      child: SizedBox(
        height: 9.0.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                      letterSpacing: 1.2)),
              Text('Rs. $totalPrice',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                      letterSpacing: 1.2))
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildProductImage(Datum productData) {
    return Expanded(
      flex: 2,
      child: SizedBox(
        width: 100,
        height: 100,
        child: ClipRRect(
            child: Container(
          child: Image.network(productData.product.productImages),
        )),
      ),
    );
  }

  slideLeftBackground() {
    return Container(
        alignment: Alignment.centerRight,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  radius: 26,
                  backgroundColor: primaryRed2,
                  child: Icon(Icons.delete, size: 36, color: Colors.white)),
              CircleAvatar(
                  radius: 26,
                  backgroundColor: primaryRed2,
                  child: Icon(Icons.delete, size: 36, color: Colors.white))
            ],
          ),
        ));
  }
}
