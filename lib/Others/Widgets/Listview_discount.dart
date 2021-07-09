import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Models/common.dart';
import '../constants/constants.dart';
import '../constants/widgets.dart';
import 'SortPage.dart';

class ListviewDiscount extends StatefulWidget {
  _ListviewDiscountState createState() => _ListviewDiscountState();
}

class _ListviewDiscountState extends State<ListviewDiscount> {
  var itemList = [];
  int len = 10;
  int maxValue = 0;

  @override
  void initState() {
    super.initState();
    Product().getAllProductsMaxValue().then((value) {
      maxValue = value;
      maxValue > len ? len = 10 : len = maxValue;
    });
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

  // void getMore() {
  //   Future.delayed(Duration(seconds: 1), () {
  //     len += 10;
  //     if (len > maxValue) len = maxValue;
  //     if (this.mounted) {
  //       setState(() {});
  //     }
  //   });
  // }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listName(AppLocalizations.of(context).arzanladys, () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => SortPage(
                    name: AppLocalizations.of(context).arzanladys,
                  )));
        }, context),
        FutureBuilder<List<Product>>(
            future: Product().getAllProducts(parametr: ({"sort": "-discount", "limit": "$len"})).then((value) {
              itemList.clear();
              value.forEach((element) {
                itemList.add(element);
              });
              return value;
            }),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError)
                return hasError();
              else if (snapshot.hasData) {
                return Container(
                    height: 290,
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: itemList.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          // if (maxValue > len) {
                          //   if (index + 1 == itemList.length) {
                          //     getMore();
                          //     return Row(
                          //       children: [
                          //         shimmerProductCard(),
                          //         shimmerProductCard(),
                          //         shimmerProductCard(),
                          //         shimmerProductCard(),
                          //       ],
                          //     );
                          //   }
                          // }
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (_) => ProductProfile(
                                        productId: itemList[index].id,
                                      )));
                            },
                            child: Container(
                              width: 200,
                              height: 300,
                              child: StaggeredCard(
                                product: itemList[index],
                              ),
                            ),
                          );
                        }));
              }
              return shimmerProduct();
            }),
      ],
    );
  }
}
