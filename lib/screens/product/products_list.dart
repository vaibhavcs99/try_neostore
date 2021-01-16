import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/repository/api_services.dart';
import 'package:try_neostore/utils/utils.dart';

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
      appBar: AppBar(title: Text(getProductCategoryName(widget.index))),
      body: FutureBuilder<ProductsListModel>(
          future: getMyModel(productCategoryId: productCategoryId),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, index) {
                Datum productData = snapshot.data.data[index];
                return Container(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, route_product_details,
                        arguments: ScreenParameters(
                            parameter1: productData.id,
                            parameter2: widget.accessToken,
                            parameter3: productData.name)),
                    child: Card(
                        elevation: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildImageHeader(productData),
                            SizedBox(
                              width: 18,
                            ),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(productData.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(height: 8),
                                  Text(productData.producer,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300)),
                                  SizedBox(height: 17),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                            'Rs. ${productData.cost.toString()}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: colorRedText,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                              height: 18,
                                              child: getRatingBar(
                                                  productData.rating)))
                                    ],
                                  ),
                                  SizedBox(height: 20),
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

  Widget buildImageHeader(Datum productData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
                child: Container(
              child: Image.network(productData.productImages),
            )),
          )
        ],
      ),
    );
  }

  Future<ProductsListModel> getMyModel(
      {@required String productCategoryId}) async {
    var myJson = await productListService(productCategoryId: productCategoryId);
    var myModel = productsListModelFromJson(myJson.data);
    return myModel;
  }
}
