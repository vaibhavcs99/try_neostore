import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/repository/api_services.dart';

class ProductList extends StatefulWidget {
  final int index;
  final String accessToken;

  ProductList({@required this.index, @required this.accessToken});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var productCategoryId = widget.index.toString();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<ProductsListModel>(
          future: getMyModel(productCategoryId: productCategoryId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, index) {
                Datum productData = snapshot.data.data[index];
                return Container(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, route_product_details,
                        arguments:  ScreenParameters(parameter1: productData.id,parameter2: widget.accessToken)),
                    child: Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    child: Container(
                                  child:
                                      Image.network(productData.productImages),
                                )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productData.name),
                              Text(productData.producer),
                              Text(productData.cost.toString()),
                              Text(productData.rating.toString()),
                              // Text(
                              //   productData.description,
                              //   overflow: TextOverflow.clip,
                              //   softWrap: false,
                              // )
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                );
              },
            );
          }),
    );
  }
    Future<ProductsListModel> getMyModel({@required String productCategoryId}) async {
    var myJson = await productListService(productCategoryId: productCategoryId);
    var myModel = productsListModelFromJson(myJson.data);
    return myModel;
  }
}