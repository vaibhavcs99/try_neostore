import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/bloc/product_details_bloc/product_details_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:sizer/sizer.dart';
import 'package:try_neostore/utils/utils.dart' as utils;

class ProductDetails extends StatefulWidget {
  final int productId;
  final String productName;
  final String accessToken;

  const ProductDetails(
      {Key key,
      @required this.productId,
      @required this.accessToken,
      @required this.productName})
      : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _quantity = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedImage = 0;

  double feedbackRating = 3.0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductDetailsBloc>(context)
        .add(OnShowProductDetails(productId: widget.productId));

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.productName),
        ),
        body: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            print('Product Details:$state');
            if (state is ProductBuyNowSuccessful) {
              showBuySnackBar();
              Navigator.pop(context);
            }
            if (state is ProductRatingSuccessful) {
              showSnackBar('Rating submitted successfully');
              Navigator.pop(context);
            }
          },
          // ignore: missing_return
          builder: (context, state) {
            if (state is ProductRatingSuccessful) {
              var productDetails = state.productDetailsModel.data;
              return buildProductScreen(productDetails);
            }
            if (state is ProductBuyNowSuccessful) {
              var productDetails = state.productDetailsModel.data;
              return buildProductScreen(productDetails);
            }
            if (state is ProductDetailsSuccessful) {
              var productDetails = state.productDetailsModel.data;
              return buildProductScreen(productDetails);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  void showBuySnackBar() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Item added to the cart successfully'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Chekout',
          onPressed: () => Navigator.pushNamed(context, route_cart_list,arguments:widget.accessToken),
          textColor: primaryRed2,
        ),
      ),
    );
  }

  Widget buildProductScreen(Data productDetails) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.0.w),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 1.0.h),
          buildDetailsAndRating(productDetails),
          SizedBox(height: 1.0.h),
          buildImages(productDetails),
          SizedBox(height: 1.0.h),
          buildDescription(productDetails),
          SizedBox(height: 1.0.h),
          buildButtonsRow(productDetails),
          SizedBox(height: 2.0.h),
        ],
      ),
    );
  }

  Widget buildButtonsRow(Data productDetails) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 3.0.w),
          Expanded(
            child: FlatButton(
              minWidth: 5.0.w,
              height: 8.0.h,
              textColor: Colors.white,
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                showAlertDialog(
                    productId: productDetails.id,
                    productName: productDetails.name,
                    productImageUrl: productDetails.productImages.first.image);
              },
              child: Text('Buy Now', style: TextStyle(fontSize: 20.0.sp)),
            ),
          ),
          SizedBox(width: 2.0.w),
          Expanded(
            child: FlatButton(
              minWidth: 5.0.w,
              height: 8.0.h,
              textColor: Colors.grey.shade800,
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () => showRatingDialog(
                  productId: productDetails.id,
                  productName: productDetails.name,
                  productImage: productDetails.productImages.first.image),
              child: Text('Rate', style: TextStyle(fontSize: 20.0.sp)),
            ),
          ),
          SizedBox(width: 3.0.w),
        ],
      ),
    );
  }

  Card buildImages(Data productDetails) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₹ ${productDetails.cost.toString()}',
                    style: TextStyle(
                        fontSize: 25,
                        color: colorRedText,
                        fontWeight: FontWeight.w500)),
                Image.asset('assets/icons/share.png')
              ],
            ),
          ),
          SizedBox(height: 1.0.h),
          Container(
              height: 26.0.h,
              child: Image.network(
                  productDetails.productImages[selectedImage].image)),
          SizedBox(height: 2.0.h),
          Container(
            height: 14.0.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                try {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedImage = index;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.all(2.0.w),
                          width: 30.0.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.red.shade200, width: 2.0)),
                          child: Image.network(
                              productDetails.productImages[index].image)),
                    ),
                  );
                } on RangeError {
                  return Card(
                      // child: Container(
                      //     width: 130,
                      //     child: Image.network(
                      //         productDetails.productImages[0].image)),
                      );
                }
              },
            ),
          ),
          SizedBox(height: 2.0.h),
        ],
      ),
    );
  }

  Card buildDetailsAndRating(Data productDetails) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productDetails.name,
              style: TextStyle(fontSize: 19.0.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4),
            Text(getProductCategoryName(productDetails.productCategoryId),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
            SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  flex: 55,
                  child: Text(productDetails.producer,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w100)),
                ),
                Expanded(
                    flex: 45,
                    child: SizedBox(
                        height: 4.0.h,
                        child: getRatingBar(productDetails.rating)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDescription(Data productDetails) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 4),
            Text(productDetails.description, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(
      {@required String productName,
      @required String productImageUrl,
      @required int productId}) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(productName),
      content: SizedBox(
          width: 65.0.w,
          height: 41.0.h,
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * 0.5,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Container(
                child: Image.network(productImageUrl),
              ),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    hintText: 'Enter a quantity',
                    labelStyle: TextStyle(fontSize: 16.0.sp)),
                keyboardType: TextInputType.number,
                initialValue: 1.toString(),
                validator: validateQuantity,
                onSaved: (newValue) {
                  _quantity = int.parse(newValue);
                },
              ),
              SizedBox(height: 1.0.h),
              Align(
                child: SizedBox(
                  width: 42.0.w,
                  height: 6.0.h,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        BlocProvider.of<ProductDetailsBloc>(context).add(
                            OnBuyNowClicked(
                                productId: productId,
                                quantity: _quantity,
                                accessToken: widget.accessToken));
                      }
                    },
                    color: Colors.red,
                    child: Text('Submit'),
                  ),
                ),
              )
            ]),
          )),
    );

    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  showRatingDialog(
      {@required String productName,
      @required String productImage,
      @required int productId}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              title: Text(productName),
              content: SizedBox(
                  width: 300,
                  height: 300,
                  child: ListView(children: [
                    Container(
                      child: Image.network(productImage),
                    ),
                    myRatingbar(),
                    Align(
                      child: RaisedButton(
                        onPressed: () {
                          BlocProvider.of<ProductDetailsBloc>(context).add(
                              OnRateButtonClicked(
                                  feedbackRating: feedbackRating,
                                  productId: productId.toString()));
                        },
                        child: Text('Rate Now'),
                      ),
                    )
                  ])));
        });
  }

  myRatingbar() {
    return Center(
      child: RatingBar.builder(
        initialRating: 3,
        minRating: 0.5,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 11.0.w,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.yellow.shade600,
        ),
        glow: true,
        glowColor: Colors.yellow.shade800,
        onRatingUpdate: (rating) {
          feedbackRating = rating;
        },
      ),
    );
  }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
