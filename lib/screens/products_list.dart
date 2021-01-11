import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/network/api_services.dart';

class ProductList extends StatefulWidget {
  final int index;
  ProductList({@required this.index});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var _productCategory = widget.index.toString();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<ProductsListModel>(
          future: productListService(_productCategory),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, index) {
                Datum productData = snapshot.data.data[index];
                return Container(
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, route_product_details,arguments: productData),
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
}

// Future<ProductsListModel> makeGetRequest(String _productCategory) async {

//   var dio = Dio();

//   Map<String, dynamic> json = {
//     'product_category_id': '$_productCategory',
//   };

//   // FormData formData = FormData.fromMap(json);

//   try {
//     var response = await dio.get(urlGetProductList, queryParameters: json);
//     final productsListModel = productsListModelFromJson(response.data);
//     print(productsListModel);
//     return productsListModel;
//   } on DioError catch (dioError) {
//     print(dioError);
//   } catch (e) {}
//   // return response.data;
// }
