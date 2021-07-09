import 'package:e_commerce_app/Others/ProductCards/MarketCircleCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Others/Models/common.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/widgets.dart';
import 'MarketProfilePage.dart';
import 'MarketSearchPage.dart';

class MarketsHomePage extends StatefulWidget {
  @override
  _MarketsHomePageState createState() => _MarketsHomePageState();
}

class _MarketsHomePageState extends State<MarketsHomePage> {
  var itemList = [];
  int len = 10;
  int maxValue = 0;

  @override
  void initState() {
    super.initState();
    // Market().getAllMarketsResult().then((value) {
    //   maxValue = value;
    //   maxValue > len ? len = 5 : len = maxValue;
    // });
  }

  Widget hasError() {
    return SizedBox(
      height: 100,
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

  getMore() {
    Future.delayed(Duration(seconds: 1), () {
      len += 10;
      if (len > maxValue) len = maxValue;
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 210,
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          listName(AppLocalizations.of(context).homePageMarkets, () {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MarketsSearchPage()));
          }, context),
          FutureBuilder<List<Market>>(
              future: Market().getAllMarkets(parametr: ({"limit": "$len"})).then((value) {
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
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: itemList.length,
                        itemBuilder: (BuildContext context, index) {
                          if (maxValue > len) {
                            if (index + 1 == itemList.length) {
                              getMore();
                              return Row(
                                children: [shimmerMarket(), shimmerMarket(), shimmerMarket(), shimmerMarket()],
                              );
                            }
                          }
                          return GestureDetector(
                              onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MarketProfilePage(marketID: snapshot.data[index].id))),
                              child: MarketCircleCard(
                                market: itemList[index],
                              ));
                        }),
                  );
                }
                return shimmer(10);
              }),
        ],
      ),
    );
  }

  Widget shimmer(int itemcount) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: itemcount,
          itemBuilder: (BuildContext context, index) {
            return shimmerMarket();
          }),
    );
  }
}
