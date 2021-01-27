import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/data_class.dart';
import '../../bloc/product_list_bloc/product_list_bloc.dart';
import '../../constants/constants.dart';
import '../../model/product_list_model.dart';
import '../../utils/utils.dart';

class ProductList extends StatefulWidget {
  final int index;
  final String accessToken;

  ProductList({@required this.index, @required this.accessToken});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var productCategoryId = widget.index.toString();

    BlocProvider.of<ProductListBloc>(context)
        .add(ShowProductList(productCategoryId: productCategoryId));

    return Scaffold(
      appBar: AppBar(title: Text(getProductCategoryName(widget.index))),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListSuccessful) {
            return buildProductListScreen(state);
          }
          if (state is ProductListUnsuccessful) {
            showSnackBar('No data found');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView buildProductListScreen( state) {
    return ListView.builder(
            itemCount: state.productsListModel.data.length,
            itemBuilder: (context, index) {
              Datum productData = state.productsListModel.data[index];
              return buildListTile(context, productData);
            },
          );
  }

  Container buildListTile(BuildContext context, Datum productData) {
    return Container(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route_product_details,
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
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      Text(productData.producer,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300)),
                      SizedBox(height: 17),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text('₹ ${productData.cost.toString()}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: colorRedText,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  height: 18,
                                  child: getRatingBar(productData.rating)))
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

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
