import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Home%20Page/Markets/MarketProfilePage.dart';
import 'package:e_commerce_app/Home%20Page/components/PhotoView.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductProfile extends StatefulWidget {
  final int productId;

  const ProductProfile({Key key, @required this.productId}) : super(key: key);
  _ProductProfileState createState() => _ProductProfileState();
}

class _ProductProfileState extends State<ProductProfile> {
  int productIdd = 0, userIdd = 0, selectedImage = 0;
  bool isOpen = false;
  bool addFavorite = false, likProduct = false;
  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int uid = _prefs.getInt('uid');
    setState(() {
      userIdd = uid;
    });
  }

  void initState() {
    getUserData();
    productIdd = widget.productId;
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        isOpen = true;
      });
    });
  }

  Widget addToCartButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RaisedButton(
          onPressed: () {
            if (userIdd != null) {
              Cart().addProductToCartById(userId: userIdd, productId: productIdd, qty: 1);
              showMessage("Sebede goşuldy", context);
            } else {
              showMessage("Harydy sebediňize goşmak üçin ulgama giriň !", context);
            }
          },
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius15),
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: AutoSizeText(
              'Sebede Goş',
              maxLines: 1,
              presetFontSizes: [22, 20, 18, 17, 16, 15, 14, 12, 11, 10],
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsBold),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePart(List images, String name) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
        child: customButton(
          image: 'assets/icons/arrow_small_left.svg',
          color: kPrimaryColor_1,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
          child: customButton(
              image: 'assets/icons/heart.svg',
              color: addFavorite ? kPrimaryColor : kPrimaryColor_1,
              onTap: () {
                if (userIdd != null) {
                  setState(() {
                    addFavorite = !addFavorite;
                  });
                  if (addFavorite == true) {
                    Product().addToFavoriteByID(widget.productId);
                    showMessage("Haryt halanlaryňyza goşuldy !", context);
                  } else {
                    Favorites().deleteFavoriteById(productId: widget.productId, userId: userIdd);
                    showMessage("Haryda halanlaryňyzda aýryldy !", context);
                  }
                } else {
                  showMessage("Haryda halanlaryňyza goşmak üçin ulgama giriň !", context);
                }
              }),
        ),
      ],
      floating: false,
      pinned: true,
      flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        var top = constraints.biggest.height;
        return FlexibleSpaceBar(
          centerTitle: true,
          title: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: top < 60 ? 1.0 : 0.0,
              child: AutoSizeText(
                "$name",
                textAlign: TextAlign.center,
                presetFontSizes: [22, 20, 18, 16, 14, 12, 10, 8],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: popPinsSemiBold, color: Colors.black),
              )),
          background: Stack(
            children: [
              Container(
                color: textFieldbackColor,
                padding: const EdgeInsets.only(bottom: 10),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    selectedImage = index;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => Photoview(
                                  images: images,
                                )));
                      },
                      child: CachedNetworkImage(
                        colorBlendMode: BlendMode.difference,
                        imageUrl: '$serverUrl${images[index]}',
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
                    );
                  },
                  pagination: new SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: new DotSwiperPaginationBuilder(size: 12, activeSize: 12, color: Colors.grey[200], activeColor: kPrimaryColor),
                  ),
                  itemCount: images.length,
                  curve: Curves.easeInOut,
                  loop: true,
                ),
              ),
              Positioned(
                top: 70,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: AnimatedOpacity(
                      opacity: top < 250 ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 500),
                      child: customButton(
                          image: 'assets/icons/share.svg',
                          color: kPrimaryColor_1,
                          onTap: () {
                            Share.share("$serverUrl${images[selectedImage]}");
                          })),
                ),
              ),
              Positioned(
                top: 130,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: AnimatedOpacity(
                    opacity: top < 350 ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 800),
                    child: customButton(
                        image: 'assets/icons/thumbs_up.svg',
                        color: likProduct ? kPrimaryColor : kPrimaryColor_1,
                        onTap: () {
                          if (userIdd != null) {
                            setState(() {
                              likProduct = !likProduct;
                            });

                            if (likProduct == true) {
                              Product().likeProductById(widget.productId);
                              showMessage("Haryda like goýduňyz !", context);
                              setState(() {});
                            } else {
                              showMessage("Haryda öň like goýguňyz!", context);
                              setState(() {});
                            }
                          } else {
                            showMessage("Haryda like goýmak üçin ulgama giriň !", context);
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
        );
      }),
      expandedHeight: 450,
    );
  }

  Widget productLikeProducts(List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: AutoSizeText("Meňzeş harytlar",
                presetFontSizes: [20, 18, 16, 14, 12, 10, 8],
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  letterSpacing: 0,
                  shadows: [Shadow(color: kPrimaryColor_1, blurRadius: 0.5)],
                  color: kPrimaryColor_1,
                  fontFamily: popPinsSemiBold,
                ))),
        Container(
          height: 300,
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          child: ListView.builder(
            itemCount: products.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductProfile(productId: products[index].id))),
                child: Container(
                  width: 200,
                  height: 300,
                  child: StaggeredCard(
                    product: products[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget productReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
            child: AutoSizeText("Teswirler",
                presetFontSizes: [22, 20, 18, 16, 14, 12, 10, 8],
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  letterSpacing: 0,
                  shadows: [Shadow(color: kPrimaryColor_1, blurRadius: 0.5)],
                  color: kPrimaryColor_1,
                  fontFamily: popPinsSemiBold,
                ))),
        FutureBuilder<List>(
            future: Product.getReviewById(widget.productId),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError)
                return hasError();
              else if (snapshot.hasData) {
                return Container(
                  height: snapshot.data.isNotEmpty ? 250 : 150,
                  child: snapshot.data.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10, left: 20, bottom: 10),
                              width: 240,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius15,
                              ),
                              child: Material(
                                elevation: 3,
                                borderRadius: borderRadius15,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            margin: EdgeInsets.only(right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: CachedNetworkImage(
                                              colorBlendMode: BlendMode.difference,
                                              imageUrl: '$serverUrl${snapshot.data[index].imagesUrl}/${snapshot.data[index].images}',
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
                                          Expanded(
                                              child: AutoSizeText(snapshot.data[index].name,
                                                  maxLines: 2,
                                                  presetFontSizes: [20, 18, 16, 14, 12, 10, 8],
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Colors.black, fontFamily: popPinsSemiBold)))
                                        ],
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: ReadMoreText(
                                            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps wFlutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unith the unified codebase.',
                                            trimLines: 4,
                                            colorClickableText: Colors.black,
                                            trimMode: TrimMode.Line,
                                            style: TextStyle(color: Colors.black, fontFamily: popPinsMedium),
                                            trimCollapsedText: 'Hemmesini gör',
                                            trimExpandedText: 'Ýap',
                                            moreStyle: TextStyle(fontSize: 14, fontFamily: popPinsSemiBold, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: AutoSizeText("Teswir Ýok !",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              presetFontSizes: [22, 20, 18, 16, 14, 12, 10, 8],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold))),
                );
              }
              return shimmerProduct();
            }),
        Container(
          height: 100,
        ),
      ],
    );
  }

  Widget marketButton(Market market) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => MarketProfilePage(
                    marketID: market.id,
                  )));
        },
        child: Material(
          elevation: 1.0,
          type: MaterialType.card,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: borderRadius15, side: BorderSide(width: 2, color: kPrimaryColor_1)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                child: Material(
                  elevation: 1.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide(width: 2, color: kPrimaryColor_1)),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        colorBlendMode: BlendMode.difference,
                        imageUrl: '$serverUrl${market.images[0]}',
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
              ),
              Expanded(
                child: AutoSizeText(
                  '${market.name_tm}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  presetFontSizes: [24, 22, 20, 18, 16, 14, 12, 10],
                  style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryPlace(Product _product) {
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

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categoryText(
                Feather.eye,
                "Görülen sany :",
                false,
              ),
              categoryText(
                Feather.thumbs_up,
                "Halanan sany :",
                false,
              ),
              categoryText(
                Feather.star,
                "Rating :",
                false,
              ),
              categoryText(
                Feather.circle,
                "Brend :",
                false,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              categoryText(
                Feather.eye,
                "${_product.viewCount}",
                true,
              ),
              categoryText(
                Feather.heart,
                "${_product.likeCount}",
                true,
              ),
              categoryText(
                Feather.star,
                "${_product.rating}",
                true,
              ),
              categoryText(
                Feather.circle,
                "${_product.brand}",
                true,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget callButton(String phoneNumber) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          RaisedButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: borderRadius10, side: BorderSide(color: kPrimaryColor_1, width: 2)),
            disabledColor: Colors.white,
            elevation: 1.0,
            disabledElevation: 1.0,
            onPressed: () {
              launch(('tel://$phoneNumber'));
            },
            child: Row(
              children: [
                Icon(Feather.phone_call, color: kPrimaryColor_1),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Jaň etmek',
                  style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                )
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget hasError() {
    return SizedBox(
      height: 200,
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.refresh_outlined,
            size: 40,
            color: kPrimaryColor_1,
          ),
          onPressed: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: isOpen
          ? FutureBuilder<Product>(
              future: Product().getProductById(widget.productId).then((value) => value),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return NoDataErrorPage(onTap: () {
                    setState(() {});
                  });
                else if (snapshot.hasData)
                  return Stack(
                    children: [
                      CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: <Widget>[
                          imagePart(snapshot.data.images, snapshot.data.name_tm),
                          SliverList(
                              delegate: SliverChildListDelegate([
                            Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText("${snapshot.data.name_tm}",
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        presetFontSizes: [24, 22, 20, 18, 16, 14, 12, 10],
                                        style: TextStyle(color: Colors.black, fontFamily: popPinsMedium)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: RichText(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        text: new TextSpan(
                                          text: '${snapshot.data.price}',
                                          style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: popPinsSemiBold),
                                          children: <TextSpan>[
                                            new TextSpan(
                                              text: ' tmt',
                                              style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: popPinsMedium),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    callButton(snapshot.data.market.phoneNumber),
                                    categoryPlace(snapshot.data),
                                    marketButton(snapshot.data.market),
                                    productLikeProducts(snapshot.data.similarProducts),
                                    productReview()
                                  ],
                                ))
                          ]))
                        ],
                      ),
                      addToCartButton()
                    ],
                  );
                else
                  return spinKit();
              })
          : spinKit(),
    ));
  }
}
