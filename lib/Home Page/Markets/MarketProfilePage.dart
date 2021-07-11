import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/Models/marketModel.dart';
import 'package:e_commerce_app/Others/Models/productModel.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketProfilePage extends StatefulWidget {
  const MarketProfilePage({Key key, this.marketID}) : super(key: key);
  final int marketID;
  _MarketProfilePageState createState() => _MarketProfilePageState();
}

class Constants {
  static const String FirstItem = 'Market barada';
  static const String SecondItem = 'Jaň etmek';
  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
  ];
}

class _MarketProfilePageState extends State<MarketProfilePage> {
  var icons = [Feather.user, Ionicons.shirt_outline, Feather.watch, Feather.gift, Feather.smartphone, Feather.headphones, FontAwesome.soccer_ball_o, Feather.book];
  bool isOpen = false;
  var text = ['Sana degişli', 'Eşikler', 'Sagatlar', 'Sowgatlar', 'Elektronika', 'Ses enjamlary', 'Sport', 'Kitaplar'];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        isOpen = true;
      });
    });
  }

  Widget suratBolegi(String imageUrl) {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(child: spinKit()),
              errorWidget: (context, url, error) => Icon(Icons.error_outline),
            ),
          ),
          Positioned.fill(
            top: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 6, 8),
                  child: customButton(
                    image: 'assets/icons/arrow_small_left.svg',
                    color: kPrimaryColor_1,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: PopupMenuButton<String>(
                    shape: RoundedRectangleBorder(borderRadius: borderRadius15),
                    child: Material(
                      elevation: 3,
                      borderRadius: borderRadius15,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius15,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Feather.more_vertical,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    onSelected: (String choice) {
                      if (choice.toString() == "Jaň etmek") {
                        launch(('tel://+99362990344'));
                      }
                    },
                    tooltip: 'Goşmaça',
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          textStyle: TextStyle(fontFamily: popPinsMedium, color: kPrimaryColor_1),
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabbarPart() {
    tabbarName(
      String name,
    ) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      );
    }

    return TabBar(
        labelColor: Colors.black,
        labelStyle: TextStyle(fontFamily: popPinsSemiBold, fontSize: 20),
        unselectedLabelStyle: TextStyle(fontFamily: popPinsMedium, fontSize: 18),
        indicatorColor: kPrimaryColor,
        indicator: BoxDecoration(border: Border.all(color: kPrimaryColor, width: 2), borderRadius: borderRadius20),
        controller: _tabController,
        tabs: <Widget>[
          tabbarName(
            'Harytlar',
          ),
          tabbarName(
            'Kategoriyalar',
          ),
        ]);
  }

  Widget kategoriya() {
    return ListView.builder(
      itemCount: icons.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            width: 100,
            margin: EdgeInsets.all(10),
            child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Icon(icons[index], size: 35, color: kPrimaryColor),
                      ),
                      Text(
                        text[index],
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: popPinsSemiBold),
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  categoryText(IconData icon, text, bool color) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        child: color
            ? AutoSizeText(
                '$text',
                overflow: TextOverflow.ellipsis,
                presetFontSizes: [18, 17, 16, 15, 14, 13, 12, 11],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color ? Colors.black : Colors.grey[500],
                  fontFamily: popPinsMedium,
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(icon, color: kPrimaryColor_1),
                  ),
                  AutoSizeText(
                    '$text',
                    overflow: TextOverflow.ellipsis,
                    presetFontSizes: [18, 17, 16, 15, 14, 13, 12, 11],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color ? Colors.black : Colors.grey[500],
                      fontFamily: popPinsMedium,
                    ),
                  ),
                ],
              ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: FutureBuilder<Market>(
                  future: Market().getMarketById(widget.marketID).then((value) => value),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return NoDataErrorPage(
                        onTap: () {
                          setState(() {});
                        },
                      );
                    else if (snapshot.hasData)
                      return isOpen
                          ? Scaffold(
                              body: suratBolegi(
                                '$serverUrl${snapshot.data.images[0]}',
                              ),
                              bottomSheet: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                      child: Container(
                                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius20),
                                  )),
                                  DraggableScrollableSheet(
                                    maxChildSize: 1,
                                    minChildSize: 0.7,
                                    expand: false,
                                    initialChildSize: 0.7,
                                    builder: (BuildContext context, ScrollController scrollController) {
                                      return SingleChildScrollView(
                                        controller: scrollController,
                                        child: Container(
                                          color: Colors.white,
                                          height: MediaQuery.of(context).size.height,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                child: Column(
                                                  children: [
                                                    AutoSizeText(
                                                      snapshot.data.name_tm,
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.ellipsis,
                                                      presetFontSizes: [34, 32, 30, 28, 26, 24, 22, 20, 18, 16, 14],
                                                      style: TextStyle(
                                                        fontFamily: popPinsSemiBold,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          RaisedButton(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(borderRadius: borderRadius10, side: BorderSide(color: kPrimaryColor_1, width: 2)),
                                                            disabledColor: Colors.white,
                                                            elevation: 1.0,
                                                            disabledElevation: 1.0,
                                                            onPressed: () {
                                                              launch(('tel://+99362990344'));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(Feather.phone_call, color: kPrimaryColor_1),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    snapshot.data.phoneNumber,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(color: kPrimaryColor_1, fontSize: 16, fontFamily: popPinsSemiBold),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          RaisedButton(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(borderRadius: borderRadius10, side: BorderSide(color: kPrimaryColor_1, width: 2)),
                                                            disabledColor: Colors.white,
                                                            elevation: 1.0,
                                                            disabledElevation: 1.0,
                                                            onPressed: () {},
                                                            child: Row(
                                                              children: [
                                                                Icon(Feather.map_pin, color: kPrimaryColor_1),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    snapshot.data.address_tm,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(color: kPrimaryColor_1, fontSize: 16, fontFamily: popPinsSemiBold),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.grey[200],
                                                thickness: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 15),
                                                child: tabbarPart(),
                                              ),
                                              Expanded(
                                                child: TabBarView(
                                                  controller: _tabController,
                                                  children: [
                                                    FutureBuilder<List<Product>>(
                                                        future: Product().getAllProducts(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError)
                                                            return NoDataErrorPage(
                                                              onTap: () {},
                                                            );
                                                          else if (snapshot.hasData)
                                                            return StaggeredGridView.countBuilder(
                                                              crossAxisCount: 2,
                                                              itemCount: snapshot.data.length,
                                                              physics: BouncingScrollPhysics(),
                                                              itemBuilder: (BuildContext context, int index) {
                                                                return GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          CupertinoPageRoute(
                                                                              builder: (context) => ProductProfile(
                                                                                    productId: snapshot.data[index].id,
                                                                                  )));
                                                                      return null;
                                                                    },
                                                                    child: StaggeredCard(
                                                                      product: snapshot.data[index],
                                                                    ));
                                                              },
                                                              staggeredTileBuilder: (index) => StaggeredTile.count(1, index.isEven ? 1.5 : 1.5),
                                                            );
                                                          else
                                                            return shimmerGrid();
                                                        }),
                                                    kategoriya(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                      child: Container(
                                    transform: Matrix4.translationValues(0.0, -120.0, 0.0),
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      elevation: 5,
                                      color: Colors.transparent,
                                      child: CachedNetworkImage(
                                        imageUrl: '$serverUrl${snapshot.data.images[0]}',
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(child: spinKit()),
                                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                      ),
                                    ),
                                  )),
                                ],
                              ))
                          : Scaffold(body: Center(child: spinKit()));
                    else
                      return Center(child: spinKit());
                  }),
            )));
  }
}
