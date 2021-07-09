import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaggeredCard extends StatefulWidget {
  const StaggeredCard({Key key, this.product}) : super(key: key);
  final Product product;
  _StaggeredCardState createState() => _StaggeredCardState();
}

class _StaggeredCardState extends State<StaggeredCard> {
  int userId;

  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int uid = _prefs.getInt('uid');
    setState(() {
      userId = uid;
    });
  }

  void initState() {
    super.initState();
    getUserData();
  }

  void showMessagee(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        backgroundColor: kPrimaryColor_1,
        shape: RoundedRectangleBorder(borderRadius: borderRadius15),
        duration: Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        content: new Text(
          "$text",
          textAlign: TextAlign.center,
          style: TextStyle(color: kPrimaryColor, fontFamily: popPinsSemiBold),
        )));
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
          elevation: 1,
          borderRadius: borderRadius10,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                        child: CachedNetworkImage(
                          colorBlendMode: BlendMode.difference,
                          imageUrl: '$serverUrl${widget.product.images[0]}',
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
                    Align(alignment: Alignment.topRight, child: likeButton(Feather.heart, true, widget.product.favored != null ? widget.product.favored : false, widget.product.id, userId)),
                    widget.product.discount > 0
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                height: 30,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0))),
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "${widget.product.discount}",
                                  style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsRegular),
                                )),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 10, right: 10, left: 10),
                decoration: BoxDecoration(color: textFieldbackColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.product.name_tm,
                      maxLines: 1,
                      presetFontSizes: [18, 16, 14],
                      stepGranularity: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: popPinsMedium,
                      ),
                    ),
                    widget.product.discount > 0
                        ? Container(
                            child: Column(
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: new TextSpan(
                                    text: '${int.tryParse(widget.product.price) * widget.product.discount * 0.01} ',
                                    style: TextStyle(color: kPrimaryColor_1, fontSize: 20, fontFamily: popPinsSemiBold),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: 'TMT ',
                                        style: TextStyle(color: kPrimaryColor_1, fontSize: 15, fontFamily: popPinsMedium),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: new TextSpan(
                                    text: '${widget.product.price ?? "0"} ',
                                    style: TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.red, color: kPrimaryColor_1, fontSize: 17, fontFamily: popPinsSemiBold),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: 'TMT ',
                                        style: TextStyle(color: kPrimaryColor_1, fontSize: 12, fontFamily: popPinsMedium),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RichText(
                            overflow: TextOverflow.ellipsis,
                            text: new TextSpan(
                              text: '${widget.product.price} ',
                              style: TextStyle(color: kPrimaryColor_1, fontSize: 20, fontFamily: popPinsSemiBold),
                              children: <TextSpan>[
                                new TextSpan(
                                  text: 'TMT ',
                                  style: TextStyle(color: kPrimaryColor_1, fontSize: 15, fontFamily: popPinsMedium),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      width: double.infinity,
                      child:
                          //  widget.product.quantityInCart > 0 && widget.product.quantityInCart != null
                          //     ? Row(
                          //         children: [
                          //           Expanded(
                          //               flex: 1,
                          //               child: FlatButton(
                          //                 color: kPrimaryColor,
                          //                 shape: RoundedRectangleBorder(
                          //                   borderRadius: BorderRadius.circular(8.0),
                          //                 ),
                          //                 onPressed: () {
                          //                   int count = widget.product.quantityInCart;
                          //                   --count;
                          //                   Cart().addProductToCartById(userId: userId, productId: widget.product.id, qty: count).then((value) => setState(() {}));
                          //                   setState(() {});
                          //                 },
                          //                 child: Text("-", style: TextStyle(fontSize: 20, color: kPrimaryColor_1, fontFamily: popPinsRegular)),
                          //               )),
                          //           Expanded(
                          //               flex: 1,
                          //               child: FlatButton(
                          //                 color: Colors.white,
                          //                 onPressed: () {},
                          //                 child:
                          //                     Text("${widget.product.quantityInCart}", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: kPrimaryColor_1, fontFamily: popPinsRegular)),
                          //               )),
                          //           Expanded(
                          //               flex: 1,
                          //               child: FlatButton(
                          //                 color: kPrimaryColor,
                          //                 shape: RoundedRectangleBorder(
                          //                   borderRadius: BorderRadius.circular(8.0),
                          //                 ),
                          //                 onPressed: () {
                          //                   int count = widget.product.quantityInCart;
                          //                   ++count;
                          //                   setState(() {
                          //                     Cart().addProductToCartById(userId: userId, productId: widget.product.id, qty: count);
                          //                   });
                          //                   setState(() {});
                          //                 },
                          //                 child: Text("+", style: TextStyle(fontSize: 20, color: kPrimaryColor_1, fontFamily: popPinsRegular)),
                          //               )),
                          //         ],
                          //       )
                          //     :
                          RaisedButton(
                        onPressed: () {
                          if (userId != null) {
                            Cart().addProductToCartById(userId: userId, productId: widget.product.id, qty: 1).then((value) {
                              showMessage("Sebede goşuldy", context);
                            });
                          } else {
                            showMessage("Harydy sebediňize goşmak üçin ulgama giriň !", context);
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                        color: kPrimaryColor,
                        elevation: 1,
                        child: AutoSizeText(
                          'Sebede goş',
                          maxLines: 1,
                          stepGranularity: 1,
                          presetFontSizes: [16, 14, 12],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsBold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
