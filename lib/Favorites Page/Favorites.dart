import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Login%20Page/login_page.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/NoConnection.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../Others/Models/common.dart';
import '../Others/NoConnectionPages/Empty_state_page.dart';
import '../Others/animations/Slide_Animation_Index.dart';
import '../Others/constants/constants.dart';
import '../Others/constants/widgets.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with SingleTickerProviderStateMixin {
  int userIdd;
  bool _isLogin = false;
  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool isLogin = _prefs.getBool("isLoggedIn");
    int uid = _prefs.getInt('uid');
    setState(() {
      userIdd = uid;
      _isLogin = isLogin == null ? false : isLogin;
    });
  }

  AnimationController slideAnimationIndex;

  void initState() {
    super.initState();
    getUserData();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    slideAnimationIndex = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    slideAnimationIndex.forward();
  }

  void dispose() {
    _connectivitySubscription.cancel();
    slideAnimationIndex.dispose();
    super.dispose();
  }

  String _connectionStatus = 'Unknown';

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
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

  AppBar appBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: AutoSizeText(
          AppLocalizations.of(context).favoritespagetitle,
          presetFontSizes: [24, 22, 20, 18, 16, 14, 12, 10, 8, 6],
          style: TextStyle(fontFamily: popPinsSemiBold, color: kPrimaryColor_1),
        ),
      );
  SlidableController controller = SlidableController();
  List<Map<String, String>> itemLike = [];

  Widget favoriteCard(Product product, index) {
    Size size = MediaQuery.of(context).size;
    double rating = double.parse(product.rating);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: (Slidable(
        controller: controller,
        actionPane: SlidableScrollActionPane(),
        actions: <Widget>[
          IconSlideAction(color: textFieldbackColor, closeOnTap: true, icon: Icons.close, onTap: () {}),
          InkWell(
            onTap: () {
              Favorites().deleteFavoriteById(userId: userIdd, productId: product.id).then((isSucces) {
                if (isSucces) {
                  showMessage('Haryt halanlaryňyzdan aýryldy !', context);
                  setState(() {});
                }
              });
              controller.activeState.dismiss();
              controller.activeState.close();
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              height: size.height,
              decoration: BoxDecoration(
                borderRadius: borderRadius20,
                color: kPrimaryColor.withOpacity(0.2),
              ),
              child: Icon(Feather.trash, color: kPrimaryColor),
            ),
          ),
        ],
        secondaryActions: <Widget>[
          InkWell(
            onTap: () {
              Favorites().deleteFavoriteById(userId: userIdd, productId: product.id).then((isSucces) {
                if (isSucces) {
                  showMessage('Haryt halanlaryňyzdan aýryldy !', context);
                  setState(() {});
                }
              });
              controller.activeState.dismiss();
              controller.activeState.close();
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: size.height,
              decoration: BoxDecoration(
                borderRadius: borderRadius20,
                color: kPrimaryColor.withOpacity(0.2),
              ),
              child: Icon(Feather.trash, color: kPrimaryColor),
            ),
          ),
          IconSlideAction(color: textFieldbackColor, closeOnTap: true, icon: Icons.close, onTap: () {}),
        ],
        actionExtentRatio: 1 / 4,
        child: Container(
          height: 165,
          decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.4), borderRadius: borderRadius30),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: borderRadius30, color: Colors.grey.shade200.withOpacity(0.4)),
                  child: Stack(
                    children: [
                      Positioned(
                          child: Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15, spreadRadius: 20)]),
                        ),
                      )),
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: borderRadius30,
                          child: CachedNetworkImage(
                            colorBlendMode: BlendMode.difference,
                            imageUrl: '$serverUrl${product.images[0]}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(child: spinKit()),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 10, top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                product.name_tm ?? "Haryt",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                stepGranularity: 2,
                                presetFontSizes: [20, 18, 16],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: popPinsSemiBold,
                                ),
                              ),
                            ),
                            GestureDetector(
                                child: itemLike[index]["isLiked"] == "false"
                                    ? Icon(
                                        Icons.favorite,
                                        color: kPrimaryColor_1,
                                        size: 30,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: kPrimaryColor_1,
                                        size: 30,
                                      ),
                                onTap: () {
                                  if (itemLike[index]["isLiked"] == "false") {
                                    setState(() {
                                      itemLike[index]["isLiked"] = "true";
                                    });
                                    Future.delayed(Duration(milliseconds: 1000), () {
                                      Favorites().deleteFavoriteById(userId: userIdd, productId: product.id).then((isSucces) {
                                        if (isSucces) {
                                          showMessage('Haryt halanlaryňyzdan aýryldy !', context);
                                          setState(() {
                                            Future.delayed(Duration(milliseconds: 200), () {
                                              itemLike[index]["isLiked"] = "false";
                                            });
                                          });
                                        }
                                      });
                                    });
                                  }
                                }),
                          ],
                        ),
                      ),
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: "${AppLocalizations.of(context).seller} : ",
                          style: TextStyle(color: kPrimaryColor_1, fontSize: 15, fontFamily: popPinsMedium),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${product.brand ?? "Satyjy"}',
                              style: TextStyle(fontSize: 18, fontFamily: popPinsMedium),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SmoothStarRating(
                            size: 20,
                            starCount: 5,
                            isReadOnly: true,
                            rating: rating,
                            color: kPrimaryColor,
                            borderColor: kPrimaryColor,
                            allowHalfRating: true,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              '${rating}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              presetFontSizes: [16, 14, 12],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: popPinsMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width,
                        child: RaisedButton(
                          onPressed: () {
                            print("fucccck");
                            print(itemLike[index]["addCart"]);
                            if (itemLike[index]["addCart"] == "false" && userIdd != null) {
                              setState(() {
                                itemLike[index]["addCart"] = "true";
                              });
                            }
                            if (itemLike[index]["addCart"] == "true" && userIdd != null) {
                              Cart().addProductToCartById(userId: userIdd, productId: product.id, qty: 1);
                              showMessage("Sebede goşuldy", context);
                              Future.delayed(Duration(milliseconds: 1000), () {
                                setState(() {
                                  itemLike[index]["addCart"] = "false";
                                });
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                          color: itemLike[index]["addCart"] == "true" ? kPrimaryColor_1 : kPrimaryColor,
                          elevation: 1,
                          child: AutoSizeText(
                            itemLike[index]["addCart"] == "true" ? "Sebede goş" : AppLocalizations.of(context).addToCart,
                            maxLines: 1,
                            stepGranularity: 1,
                            presetFontSizes: [16, 14, 12, 10, 8, 6],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: itemLike[index]["addCart"] == "true" ? kPrimaryColor : kPrimaryColor_1, fontFamily: popPinsBold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget build(BuildContext context) {
    return _connectionStatus == "ConnectivityResult.none"
        ? NoConnnectionPage()
        : Scaffold(
            appBar: appBar(),
            backgroundColor: textFieldbackColor,
            body: _isLogin
                ? FutureBuilder<List<Product>>(
                    future: Favorites().getAllFavoriteProducts(userId: userIdd).then((value) {
                      value.forEach((element) {
                        itemLike.add({"isLiked": "false", "addCart": "false"});
                      });
                      return value;
                    }),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasError)
                        return NoDataErrorPage(onTap: () {
                          setState(() {});
                        });
                      else if (snapshot.hasData) {
                        return snapshot.data.length > 0
                            ? ListView.builder(
                                itemCount: snapshot.data.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Slide_Animation_mine(
                                      index: index,
                                      animationController: slideAnimationIndex,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(CupertinoPageRoute(
                                                builder: (context) => ProductProfile(
                                                      productId: snapshot.data[index].id,
                                                    )));
                                            return null;
                                          },
                                          child: favoriteCard(snapshot.data[index], index)));
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: EmptyPage(
                                  selectedIndex: 3,
                                ),
                              );
                      }
                      return Center(child: spinKit());
                    })
                : EmptyPage(
                    selectedIndex: 2,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                  ),
          );
  }
}
