import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/data_class.dart';
import '../constants/constants.dart';
import 'widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  final String accessToken;

  const HomeScreen({Key key, this.accessToken}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List productNames = ['Tables', 'Chairs', 'Sofa', 'Bed', 'Dining set'];

  List<String> productImages = [
    'assets/tableicon.png',
    'assets/chairsicon.png',
    'assets/sofaicon.png',
    'assets/cupboardicon.png',
  ];
  List<String> sliderImages = [
    'assets/slider_img1.jpg',
    'assets/slider_img2.jpg',
    'assets/slider_img3.jpg',
    'assets/slider_img4.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.h),
              child: InkWell(
                  onTap: () => Navigator.pushNamed(context, route_cart_list,
                      arguments: widget.accessToken),
                  child: Icon(Icons.shopping_cart_outlined)),
            )
          ],
        ),
        drawer: Drawer(
          child: MyDrawer(accessToken: widget.accessToken),
        ),
        body: ListView(
          children: [
            buildCarouselSlider(),
            buildProductsGrid(context),
          ],
        ),
      ),
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(autoPlayInterval: Duration(seconds: 3),
          aspectRatio: 16 / 9,
          autoPlay: true,
          enlargeCenterPage: true,
          disableCenter: true),
      items: sliderImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: 40.0.h,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.asset(image));
          },
        );
      }).toList(),
    );
  }

  Widget buildProductsGrid(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 1.0.h),
      child: SizedBox(
        height: 60.0.h,
        child: Container(
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return Container(
                    child: InkWell(
                  onTap: () => Navigator.pushNamed(context, route_product_list,
                      //imdex+1 is product category id number
                      arguments: ScreenParameters(
                          parameter1: index + 1, parameter2: widget.accessToken)),
                  child: Card(
                    child: Container(child: Image.asset(productImages[index])),
                  ),
                ));
              })),
        ),
      ),
    );
  }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
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
