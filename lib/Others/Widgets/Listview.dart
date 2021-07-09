import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:e_commerce_app/Others/Widgets/SortPage.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Listview extends StatefulWidget {
  @override
  _ListviewState createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  var itemList = [];
  int len = 10;
  int maxValue = 0;

  @override
  void initState() {
    super.initState();
    Product().getAllProductsMaxValue().then((value) {
      maxValue = value;
      if (maxValue >= len) {
        len = 10;
      } else
        len = maxValue;
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

  void getMore() {
    Future.delayed(Duration(seconds: 1), () {
      if (len > maxValue)
        len = maxValue;
      else
        len += 10;
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        listName(AppLocalizations.of(context).newProducts, () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => SortPage(
                    name: AppLocalizations.of(context).newProducts,
                  )));
        }, context),
        FutureBuilder<List<Product>>(
            future: Product().getAllProducts().then((value) {
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
                  height: 300,
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: itemList.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
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
                        // child: ProductCard(
                        //   product: itemList[index],
                        //   discount: false,
                        // )
                      );
                    },
                  ),
                );
              }
              return shimmerProduct();
            }),
      ],
    );
  }
}
