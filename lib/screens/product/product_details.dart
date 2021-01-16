import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:try_neostore/repository/api_services.dart';
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

  double myFeedbackRating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.productName),
        ),
        body: FutureBuilder<ProductDetailsModel>(
            future: getMyModel(id: widget.productId),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              var productDetails = snapshot.data.data;
              var productDetails2 = productDetails;
              return ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productDetails.name,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                              getProductCategoryName(
                                  productDetails.productCategoryId),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w100)),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                flex: 75,
                                child: Text(productDetails.producer,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w100)),
                              ),
                              Expanded(
                                  flex: 25,
                                  child: SizedBox(
                                      height: 18,
                                      child:
                                          getRatingBar(productDetails.rating)))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rs. ${productDetails2.cost.toString()}',
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
                            child: Image.network(productDetails
                                .productImages[selectedImage].image)),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              try {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        print(index);
                                        selectedImage = index;
                                      });
                                    },
                                    child: Container(
                                        width: 120,
                                        child: Image.network(productDetails
                                            .productImages[index].image)),
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
                  ),
                  buildDescription(productDetails),
                  Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: MyButton(
                              aspectX: 227,
                              aspectY: 68,
                              textColor: Colors.white,
                              color: Colors.red,
                              onPressed: () {
                                showAlertDialog(
                                    productId: productDetails.id,
                                    productName: productDetails.name,
                                    productImageUrl: productDetails
                                        .productImages.first.image);
                              },
                              myText: 'Buy Now',
                              fontSize: 20.0),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: MyButton(
                            aspectX: 227,
                            aspectY: 68,
                            textColor: Colors.grey,
                            color: colorGreyBackground,
                            onPressed: () => showRatingDialog(
                                productId: productDetails.id,
                                productName: productDetails.name,
                                productImage:
                                    productDetails.productImages.first.image),
                            myText: 'Rate',
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }));
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
            Text(productDetails.description, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Future<ProductDetailsModel> getMyModel({@required int id}) async {
    var myJson = await productDetailsService(myProductId: id.toString());
    var myModel = productDetailsModelFromJson(myJson.data);
    return myModel;
  }

  void showAlertDialog(
      {@required String productName,
      @required String productImageUrl,
      @required int productId}) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(productName),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.5,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Container(
                child: Image.network(productImageUrl),
              ),
              // Text('Enter Quantity of product'),
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
                  width: MediaQuery.of(context).size.width/2  ,
                  child: FlatButton(textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        await addItemCartService(
                            myProductId: productId,
                            quantity: _quantity,
                            accessToken: widget.accessToken);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, route_cart_list,
                            arguments: widget.accessToken);
                      } else {
                        // _scaffoldKey.currentState.showSnackBar(
                        //     SnackBar(content: Text('Please Enter all Fields')));
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
                        onPressed: () => setProductRatingService(
                            productId: productId.toString(),
                            rating: myFeedbackRating),
                        child: Text('Rate Now'),
                      ),
                    )
                  ])));
        });
  }

  myRatingbar() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 0.5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.red.shade400,
      ),
      glow: true,
      glowColor: Colors.redAccent,
      onRatingUpdate: (rating) {
        setState(() {
          myFeedbackRating = rating;
        });
      },
    );
  }
}
