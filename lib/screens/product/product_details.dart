import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/bloc/product_details_bloc/product_details_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';
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
  double screenWidth;
  double screenHeight;
  double feedbackRating = 3.0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    BlocProvider.of<ProductDetailsBloc>(context)
        .add(OnShowProductDetails(productId: widget.productId));

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.productName),
        ),
        body: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            if (state is ProductBuyNowSuccessful) {
              Navigator.pop(context);
              Navigator.pushNamed(context, route_cart_list,
                  arguments: widget.accessToken);
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
            if (state is ProductDetailsSuccessful) {
              var productDetails = state.productDetailsModel.data;

              return buildProductScreen(productDetails);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  ListView buildProductScreen(Data productDetails) {
    return ListView(
      shrinkWrap: true,
      children: [
        buildDetailsAndRating(productDetails),
        buildImages(productDetails),
        buildDescription(productDetails),
        buildButtonsRow(productDetails)
      ],
    );
  }

  Card buildButtonsRow(Data productDetails) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: MyButton(
                aspectX: 227,
                aspectY: (screenWidth / 4).round(),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  showAlertDialog(
                      productId: productDetails.id,
                      productName: productDetails.name,
                      productImageUrl:
                          productDetails.productImages.first.image);
                },
                myText: 'Buy Now',
                fontSize: 20.0),
          ),
          SizedBox(width: 8),
          Expanded(
            child: MyButton(
              aspectX: 227,
              aspectY: (screenWidth / 4).round(),
              textColor: Colors.grey,
              color: colorGreyBackground,
              onPressed: () => showRatingDialog(
                  productId: productDetails.id,
                  productName: productDetails.name,
                  productImage: productDetails.productImages.first.image),
              myText: 'Rate',
              fontSize: 20.0,
            ),
          ),
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
          Container(
              height: 200,
              child: Image.network(
                  productDetails.productImages[selectedImage].image)),
          SizedBox(
            height: 140,
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
                          width: 120,
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
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4),
            Text(getProductCategoryName(productDetails.productCategoryId),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
            SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  flex: 75,
                  child: Text(productDetails.producer,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
                ),
                Expanded(
                    flex: 25,
                    child: SizedBox(
                        height: 18, child: getRatingBar(productDetails.rating)))
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Container(
                child: Image.network(productImageUrl),
              ),
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Quantity', hintText: 'Enter a quantity'),
                keyboardType: TextInputType.number,
                validator: validateQuantity,
                onSaved: (newValue) {
                  _quantity = int.parse(newValue);
                },
              ),
              Align(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
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
        itemSize: 35.0,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.red.shade400,
        ),
        glow: true,
        glowColor: Colors.redAccent,
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
