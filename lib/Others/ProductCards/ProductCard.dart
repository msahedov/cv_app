import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool discount;
  const ProductCard({Key key, this.product, this.discount}) : super(key: key);

  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int userId;
  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int uid = _prefs.getInt('uid');
    setState(() {
      userId = uid;
      print(userId);
    });
  }

  void initState() {
    super.initState();
    getUserData();
  }

  bool addCart = false;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 15, bottom: 10),
      width: 170,
      decoration: BoxDecoration(
        borderRadius: borderRadius10,
      ),
      child: Material(
        elevation: 3,
        borderRadius: borderRadius10,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: widget.discount
                      ? Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    colorBlendMode: BlendMode.difference,
                                    imageUrl: '$serverUrl${widget.product.images}',
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
                                  )),
                            ),
                            Positioned(
                              right: -50,
                              top: -10,
                              child: RotationTransition(
                                turns: new AlwaysStoppedAnimation(45 / 360),
                                child: Container(
                                  color: kPrimaryColor,
                                  padding: EdgeInsets.only(bottom: 5, left: 50, right: 50, top: 20),
                                  child: Text(
                                    '${widget.product.discount} %',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsBold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : CachedNetworkImage(
                          colorBlendMode: BlendMode.difference,
                          imageUrl: '$serverUrl${widget.product.images}',
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
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                decoration: BoxDecoration(
                  color: textFieldbackColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name_tm ?? "Haryt",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: popPinsMedium,
                        )),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 40),
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: new TextSpan(
                              text: '${widget.product.price ?? "0"}',
                              style: TextStyle(color: kPrimaryColor_1, fontSize: 18, fontFamily: popPinsSemiBold),
                              children: <TextSpan>[
                                new TextSpan(
                                  text: ' TMT ',
                                  style: TextStyle(color: kPrimaryColor_1, fontSize: 14, fontFamily: popPinsRegular),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              if (addCart == false && userId != null) {
                                setState(() {
                                  addCart = true;
                                });
                              }
                              if (addCart == true && userId != null) {
                                Cart().addProductToCartById(userId: userId, productId: widget.product.id, qty: 1);
                                showMessage("Sebede goşuldy", context);
                                Future.delayed(Duration(milliseconds: 1000), () {
                                  setState(() {
                                    addCart = false;
                                  });
                                });
                              } else {
                                showMessage("Harydy sebediňize goşmak üçin ulgama giriň !", context);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Material(
                                borderRadius: borderRadius10,
                                elevation: 3,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: kPrimaryColor_1, borderRadius: borderRadius10),
                                  child: addCart ? Icon(Icons.done, color: kPrimaryColor) : Icon(FeatherIcons.shoppingCart, color: kPrimaryColor),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
