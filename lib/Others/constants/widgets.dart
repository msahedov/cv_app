import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/Models/productModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as chasing_dots;
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'constants.dart';

final InputDecoration otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide(color: kTextColor),
  );
}

OutlineInputBorder focusBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide(color: kPrimaryColor_1),
  );
}

OutlineInputBorder outlineInputBorder1() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: kTextColor),
  );
}

final TextStyle buttonTextStyle = TextStyle(color: kPrimaryColor_1, fontWeight: FontWeight.bold, fontFamily: popPinsRegular);

final TextStyle headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const LinearGradient kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);

AppBar primaryAppBar({String title, List<Widget> actions, BuildContext context}) {
  return AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios,
        size: 25,
        color: kPrimaryColor_1,
      ),
    ),
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: kPrimaryColor_1,
        fontWeight: FontWeight.bold,
        fontFamily: popPinsRegular,
      ),
    ),
    actions: actions,
    backgroundColor: Colors.white,
  );
}

Widget divider() {
  return Container(
    color: Colors.black12,
    width: 1,
    height: 20,
  );
}

Widget likeButton(IconData icon, bool padding, bool isFavore, int productId, int userId) {
  return InkWell(
    onTap: () {
      Product().addToFavoriteByID(productId).then((value) {
        if (!value) {
          Favorites().deleteFavoriteById(productId: productId, userId: userId);
        }
      });
    },
    child: Container(
      margin: EdgeInsets.only(top: padding ? 10 : 5, right: 10),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: isFavore
                ? Icon(
                    Icons.favorite,
                    color: kPrimaryColor,
                  )
                : Icon(
                    icon,
                    color: kPrimaryColor_1,
                  )),
      ),
    ),
  );
}

Widget filterIcon({IconData icon, String title, Function onTap, bool selected}) {
  return InkWell(
    onTap: onTap(),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        children: [
          Icon(icon),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AutoSizeText(
              title,
              presetFontSizes: [16, 14, 12, 10, 8],
              style: TextStyle(fontFamily: popPinsRegular),
            ),
          )),
          selected
              ? Icon(
                  Icons.check,
                  color: kPrimaryColor_1,
                )
              : Container()
        ],
      ),
    ),
  );
}

Widget shimmerMarket() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    child: Container(
      padding: EdgeInsets.only(left: 15, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 90,
            margin: const EdgeInsets.only(top: 10),
            color: Colors.grey,
            child: Text('   '),
          ),
        ],
      ),
    ),
  );
}

Widget shimmerProductCard() {
  return Container(
    margin: EdgeInsets.only(right: 10, left: 15, bottom: 10),
    width: 170,
    decoration: BoxDecoration(
      borderRadius: borderRadius10,
    ),
    child: Material(
      elevation: 1,
      borderRadius: borderRadius10,
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                  width: double.infinity,
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                        color: Colors.grey[300],
                        child: Text(
                          'hjhvjhvjhvjhkjbkv ',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: popPinsSemiBold),
                        )),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                        color: Colors.grey[300],
                        child: Text(
                          ' jbjljnlb',
                          overflow: TextOverflow.ellipsis,
                        )),
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

Widget shimmerProduct() {
  return Container(
    height: 220,
    margin: EdgeInsets.only(bottom: 20),
    width: double.infinity,
    child: ListView.builder(
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return shimmerProductCard();
      },
    ),
  );
}

Widget shimmerCartListView(context, int itemCount) {
  return ListView.builder(
    itemCount: itemCount,
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, int index) {
      return shimmerCart(context);
    },
  );
}

Widget shimmerCart(context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: double.infinity,
    height: 170,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
    child: Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 1,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: size.height,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                        color: Colors.grey[300],
                        child: Text(
                          '                      ',
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                        color: Colors.grey[300],
                        child: Text(
                          '                 ',
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 25),
                    width: double.infinity,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: RaisedButton(
                            onPressed: () {},
                            color: Colors.grey[300],
                            elevation: 1,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      backgroundColor: kPrimaryColor_1,
      duration: Duration(milliseconds: 1000),
      behavior: SnackBarBehavior.floating,
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: kPrimaryColor, fontFamily: popPinsSemiBold),
      )));
}

Widget shimmerGrid() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 3 / 4.8,
      crossAxisCount: 2,
    ),
    itemCount: 20,
    physics: BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Material(
            elevation: 1,
            borderRadius: borderRadius10,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: borderRadius10,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          color: Colors.grey,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 10, right: 10, left: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          color: Colors.grey,
                          child: AutoSizeText(
                            '               ',
                            maxLines: 1,
                            presetFontSizes: [18, 16, 14],
                            stepGranularity: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: popPinsMedium,
                            ),
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {},
                            color: kPrimaryColor_1,
                            child: AutoSizeText(
                              'Sebede goşuldy',
                              maxLines: 1,
                              stepGranularity: 1,
                              presetFontSizes: [16, 14, 12],
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: kPrimaryColor, fontFamily: popPinsBold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      );
    },
  );
}

Widget listName(String name, Function onTap, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(name,
              presetFontSizes: [20, 18, 16, 14, 12, 10, 8],
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                letterSpacing: 0,
                shadows: [Shadow(color: kPrimaryColor_1, blurRadius: 0.5)],
                color: kPrimaryColor_1,
                fontFamily: popPinsSemiBold,
              )),
        ),
        GestureDetector(
          onTap: onTap,
          child: AutoSizeText(AppLocalizations.of(context).allBtn,
              minFontSize: 16,
              stepGranularity: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: popPinsSemiBold,
                color: kPrimaryColor,
              )),
        ),
      ],
    ),
  );
}

Widget spinKit() {
  return chasing_dots.SpinKitChasingDots(
    size: 40,
    color: kPrimaryColor_1,
  );
}

primaryDialog({BuildContext context, String positiveAnswertext, String negativeAnswertext, String text, Function positivePress, Function negativePress}) {
  var myGroup = AutoSizeGroup();

  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black12.withOpacity(0.6),
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, borderRadius: borderRadius20),
              constraints: BoxConstraints(maxWidth: 350, minWidth: 250, minHeight: 200, maxHeight: 200),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    AutoSizeText(
                      text,
                      maxLines: 4,
                      presetFontSizes: [18, 16, 14],
                      stepGranularity: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontFamily: popPinsMedium),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: negativePress,
                            child: AutoSizeText(
                              negativeAnswertext,
                              textAlign: TextAlign.center,
                              group: myGroup,
                              presetFontSizes: [
                                18,
                                16,
                                14,
                                12,
                                10,
                                8,
                              ],
                              style: TextStyle(color: Colors.red, fontFamily: popPinsRegular),
                            ),
                          ),
                        ),
                        divider(),
                        Expanded(
                          child: InkWell(
                            onTap: positivePress,
                            child: AutoSizeText(
                              positiveAnswertext,
                              group: myGroup,
                              textAlign: TextAlign.center,
                              presetFontSizes: [
                                18,
                                16,
                                14,
                                12,
                                10,
                                8,
                              ],
                              style: TextStyle(color: Colors.green, fontFamily: popPinsRegular),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    animationType: DialogTransitionType.slideFromTop,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 500),
  );
}

void showMessage(String text, BuildContext context) {
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

Widget customButton({
  String image,
  Color color,
  Function onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Material(
        elevation: 3,
        borderRadius: borderRadius15,
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: borderRadius15,
              color: Colors.white,
            ),
            child: SvgPicture.asset(
              image,
              color: color,
              width: 25,
            ))),
  );
}

Widget customButton2({IconData icon, Color color, Function onTap, double iconsize}) {
  return GestureDetector(
    onTap: onTap,
    child: Material(
        elevation: 3,
        borderRadius: borderRadius15,
        child: Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: borderRadius15,
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: color,
              size: iconsize,
            ))),
  );
}

Widget listviewName(String title, GestureTapCallback press) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(title,
            minFontSize: 18,
            stepGranularity: 2,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Poppins_SemiBold',
            )),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: AutoSizeText('Hemmesi',
              minFontSize: 14, stepGranularity: 2, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: 'Poppins_Medium', color: kPrimaryColor_1)),
        ),
      ],
    ),
  );
}
