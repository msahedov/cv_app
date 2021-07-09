import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Login%20Page/login_page.dart';
import 'package:e_commerce_app/Others/Models/cartModel.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/Models/productModel.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/NoConnection.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/Empty_state_page.dart';
import 'package:e_commerce_app/Others/animations/Slide_Animation_Index.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Others/constants/constants.dart';
import 'components/ShippingAdress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  bool isOpen = false;
  bool _isLogin = false;
  int len;
  int itemLength;
  int userIdd;
  AnimationController slideAnimationIndex;
  SlidableController controller = SlidableController();
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

  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool isLogin = _prefs.getBool("isLoggedIn");
    int uid = _prefs.getInt('uid');
    setState(() {
      userIdd = uid;
      _isLogin = isLogin == null ? false : isLogin;
    });
    //  getCartItemsLenngth();
  }

  // void getCartItemsLenngth() async {
  //   List<Cart> carts = await Cart().getAllItemsFromCart(userId: userIdd);
  //   if (this.mounted) {
  //     len = carts.length;
  //     setState(() {});
  //   }
  // }

  double totalPrice;
  // Future<double> _totalPrice(List<Cart> cartItems) async {
  //   double totalPrice = 0.0;
  //   for (int i = 0; i < cartItems.length; i++) {
  //     int productId = int.parse(cartItems[i].productId);
  //     Product product = await Product().getProductById(productId);
  //     double price = double.parse(product.price != null ? product.price : "0.0");
  //     totalPrice += price * cartItems[i].qty;
  //   }
  //   return totalPrice;
  // }

  void initState() {
    super.initState();
    initConnectivity();
    Cart().getAllItemsFromCart(userId: 6);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Future.delayed(Duration(milliseconds: 500), () {
      isOpen = true;
      if (this.mounted) {
        setState(() {});
      }
    });
    getUserData();
    slideAnimationIndex = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    slideAnimationIndex.forward();
  }

  void dispose() {
    _connectivitySubscription.cancel();
    slideAnimationIndex.dispose();
    super.dispose();
  }

  AppBar appBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: AutoSizeText(
          AppLocalizations.of(context).cartPageTitle,
          presetFontSizes: [24, 22, 20, 18, 16, 14, 12, 10, 8, 6],
          style: TextStyle(fontFamily: popPinsSemiBold, color: kPrimaryColor_1),
        ),
      );

  Widget floatingActionButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 15, right: 0),
      width: 170,
      height: 50,
      child: FloatingActionButton(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        isExtended: true,
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => ShippingAdress(
                    userId: userIdd,
                    bahasy: totalPrice.toStringAsFixed(2),
                  )));
        },
        backgroundColor: kPrimaryColor_1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context).orderingBtn,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: popPinsSemiBold, color: kPrimaryColor),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: kPrimaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartCard({Cart cart, int index}) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Slidable(
          closeOnScroll: true,
          controller: controller,
          actionPane: SlidableScrollActionPane(),
          actions: <Widget>[
            IconSlideAction(color: textFieldbackColor, closeOnTap: true, icon: Icons.close, onTap: () {}),
            GestureDetector(
              onTap: () {
                Cart().removeProductFromCart(userId: userIdd, productId: cart.id).then((isSucces) {
                  if (isSucces) {
                    showMessage("Haryt sebediňizden aýryldy", context);
                    setState(() {
                      controller.activeState.dismiss();
                      controller.activeState.close();
                    });
                  }
                });
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
            GestureDetector(
              onTap: () {
                Cart().removeProductFromCart(userId: userIdd, productId: cart.id).then((isSucces) {
                  if (isSucces) {
                    showMessage("Haryt sebediňizden aýryldy", context);
                    setState(() {
                      controller.activeState.dismiss();
                      controller.activeState.close();
                    });
                  }
                });
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
          child: Material(
            elevation: 1,
            borderRadius: borderRadius30,
            child: Container(
              height: size.height / 5,
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: borderRadius30),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: borderRadius30,
                        child: CachedNetworkImage(
                          colorBlendMode: BlendMode.difference,
                          imageUrl: '$serverUrl${cart.images[0]}',
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
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: AutoSizeText(
                              cart.name_tm ?? "Haryt",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              stepGranularity: 2,
                              presetFontSizes: [24, 22, 20, 18, 16],
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: popPinsMedium,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: new TextSpan(
                                      text: '${cart.price ?? "0"}',
                                      style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: popPinsSemiBold),
                                      children: <TextSpan>[
                                        new TextSpan(
                                          text: ' TMT ',
                                          style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: popPinsMedium),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (userIdd == null) {
                                          showMessage("Haryda halanlaryňyza goşmak üçin ulgama giriň !", context);
                                        } else {
                                          if (userIdd != null) {
                                            setState(() {
                                              Product().addToFavoriteByID(cart.id);
                                              showMessage("Haryt halanlaryňyza goşuldy !", context);
                                            });
                                          } else {
                                            setState(() {
                                              Favorites().deleteFavoriteById(productId: cart.id, userId: userIdd);
                                              showMessage("Haryda halanlaryňyzda aýryldy !", context);
                                            });
                                          }
                                        }
                                      },
                                      // child: itemLike[index]["isLiked"] == "false"
                                      //     ? Icon(
                                      //         Icons.favorite_border,
                                      //         color: kPrimaryColor_1,
                                      //         size: 30,
                                      //       )
                                      //     :
                                      child: Icon(
                                        Icons.favorite,
                                        color: kPrimaryColor,
                                        size: 32,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (cart.qty <= 0) {
                                    Cart().removeProductFromCart(userId: userIdd, productId: cart.id).then((isSucces) {
                                      print(isSucces);
                                      if (isSucces) {
                                        setState(() {});

                                        showMessage("Haryt sebediňizden aýryldy", context);
                                      }
                                    });
                                  } else {
                                    int productCount = cart.qty;
                                    --productCount;
                                    Cart().addProductToCartById(userId: userIdd, productId: cart.id, qty: productCount).then((isSucces) {
                                      if (isSucces) {
                                        setState(() {});
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.remove,
                                      color: kPrimaryColor_1,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: AutoSizeText(
                                  '${cart.qty}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  stepGranularity: 2,
                                  presetFontSizes: [22, 20, 18, 16, 14],
                                  style: TextStyle(color: Colors.black, fontFamily: popPinsSemiBold),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  int countInStock = int.parse(cart.countInStock);
                                  if (countInStock > cart.qty) {
                                    int productCount = cart.qty;
                                    ++productCount;
                                    Cart().addProductToCartById(userId: userIdd, productId: cart.id, qty: productCount).then((isSucces) {
                                      if (isSucces) {
                                        setState(() {});
                                      }
                                    });
                                  } else {
                                    showMessage("Haryt ammarda gutardy", context);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                  child: FittedBox(
                                    child: Icon(
                                      Feather.plus,
                                      color: kPrimaryColor_1,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget build(BuildContext context) {
    return _connectionStatus == "ConnectivityResult.none" || _connectionStatus == "Unknown"
        ? NoConnnectionPage()
        : Scaffold(
            backgroundColor: textFieldbackColor,
            appBar: appBar(),
            //floatingActionButton: (_isLogin && len > 0) ? floatingActionButton() : SizedBox.shrink(),
            body: _isLogin
                ? isOpen
                    ? FutureBuilder<List<Cart>>(
                        future: Cart().getAllItemsFromCart(userId: userIdd).then((value) {
                          itemLength = value.length;
                          return value;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return NoDataErrorPage(
                              onTap: () {
                                setState(() {});
                              },
                            );
                          else if (snapshot.hasData) {
                            // if (snapshot.data.length == 0) {
                            //   // getCartItemsLenngth();
                            // }

                            return itemLength > 0
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return FutureBuilder<Product>(
                                          future: Product().getProductById(snapshot.data[index].id),
                                          builder: (context, _snapshot) {
                                            if (_snapshot.hasError)
                                              return SizedBox(
                                                height: 175,
                                                width: MediaQuery.of(context).size.width,
                                                child: Center(
                                                    child: IconButton(
                                                        icon: Icon(Icons.refresh, color: kPrimaryColor_1, size: 30),
                                                        onPressed: () {
                                                          setState(() {});
                                                        })),
                                              );
                                            else if (_snapshot.hasData) {
                                              // int id = int.parse(snapshot.data[index].id);
                                              return Slide_Animation_mine(
                                                index: index,
                                                animationController: slideAnimationIndex,
                                                child: GestureDetector(
                                                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                                                        builder: (context) => ProductProfile(
                                                              productId: snapshot.data[index].id,
                                                            ))),
                                                    child: cartCard(cart: snapshot.data[index], index: index)),
                                              );
                                            }
                                            return shimmerCart(context);
                                          });
                                    },
                                  )
                                : EmptyPage(
                                    selectedIndex: 0,
                                  );
                          }
                          return shimmerCartListView(context, itemLength);
                        })
                    : Center(
                        child: spinKit(),
                      )
                : EmptyPage(
                    selectedIndex: 1,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                  ),
          );
  }
}
