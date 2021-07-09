import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:e_commerce_app/Others/Models/categoryModel.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/NoConnection.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/Widgets/SortPage_Category.dart';
import 'package:e_commerce_app/Others/animations/slide_animation.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with TickerProviderStateMixin {
  AnimationController _slidecontroller;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _slidecontroller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
    _slidecontroller.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {}
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  Widget _layoutHorizontal(BuildContext context) {
    AppBar appBar(BuildContext context) => AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context).categories,
            style: TextStyle(
              color: kPrimaryColor_1,
              fontWeight: FontWeight.bold,
              fontFamily: popPinsRegular,
              fontSize: 20,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        );

    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 480) {
              return _horizontalWidget(context, constraints, 2);
            } else if (constraints.maxWidth > 400 && constraints.maxWidth <= 800) {
              return _horizontalWidget(context, constraints, 2);
            } else if (constraints.maxWidth > 800 && constraints.maxWidth <= 1100) {
              return _horizontalWidget(context, constraints, 3);
            } else {
              return _horizontalWidget(context, constraints, 4);
            }
          },
        ),
      ),
    );
  }

  Widget _horizontalWidget(BuildContext context, BoxConstraints constraints, int crossAxisCount) {
    subCategoryItemCard(Category category) => GestureDetector(
          onTap: () => Navigator.push(context, PageTransition(child: SortPage_Category(name: category.name_tm, id: category.id), type: PageTransitionType.bottomToTop)),
          child: Container(
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 10,
                  child: PhysicalModel(
                    elevation: 1,
                    borderRadius: radius,
                    color: textFieldbackColor,
                    child: ClipRRect(
                      borderRadius: radius,
                      child: Container(
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("$serverUrl${category.image}"), fit: BoxFit.cover), color: Colors.white, borderRadius: radius),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: radius,
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      color: Colors.transparent,
                      child: Text(
                        category.name_tm,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kPrimaryColor_1, fontWeight: FontWeight.bold, fontFamily: popPinsRegular),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      color: textFieldbackColor,
      child: FutureBuilder<List<Category>>(
          future: Category.getAllCategories.then((value) => value),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return NoDataErrorPage(
                onTap: () {
                  setState(() {});
                },
              );
            else if (snapshot.hasData)
              return GridView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return SlideAnimationListItem(
                      position: index,
                      itemCount: snapshot.data.length,
                      slideDirection: SlideDirection.fromBottom,
                      animationController: _slidecontroller,
                      child: subCategoryItemCard(
                        snapshot.data[index],
                      ));
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0, childAspectRatio: 3 / 4),
              );
            else
              return Center(child: SpinKitChasingDots(color: kPrimaryColor_1));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == "ConnectivityResult.none" ? NoConnnectionPage() : _layoutHorizontal(context);
  }
}
