import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/ProductCards/MarketCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../Others/Models/common.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/widgets.dart';
import 'MarketProfilePage.dart';

class MarketsSearchPage extends StatefulWidget {
  _MarketsSearchPageState createState() => _MarketsSearchPageState();
}

class _MarketsSearchPageState extends State<MarketsSearchPage> {
  var itemList = [];
  int len = 10;
  int maxValue = 0;

  TextEditingController _searchController = TextEditingController();
  List<Market> _searchResult = [];

  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void initState() {
    _searchController.addListener(() {
      setState(() {});
    });
    // Market().getAllMarketsResult().then((value) {
    //   maxValue = value;
    //   maxValue > len ? len = 5 : len = maxValue;
    // });

    super.initState();
  }

  Widget hasData(List<Market> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (maxValue > len) {
          if (index + 1 == itemList.length) {
            getMore();
            return spinKit();
          }
        }
        return InkWell(
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MarketProfilePage(marketID: snapshot[index].id))),
            child: MarketCard(
              market: snapshot[index],
            ));
      },
    );
  }

  void getMore() {
    Future.delayed(Duration(seconds: 2), () {
      len += 10;
      if (len > maxValue) len = maxValue;
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  AppBar appBar() => AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context).homePageMarkets,
          style: TextStyle(color: Colors.black, fontFamily: popPinsMedium),
        ),
      );

  Widget search() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Material(
        elevation: 1,
        borderRadius: borderRadius15,
        color: Colors.white,
        child: TextField(
          onChanged: (text) => searchByMarketName(text),
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          controller: _searchController,
          style: TextStyle(fontFamily: popPinsMedium, color: Colors.black),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).searchMarkets,
            hintStyle: TextStyle(fontSize: 14, fontFamily: popPinsMedium, color: Colors.grey[500]),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset('assets/icons/search.svg'),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      searchByMarketName('');
                      setState(() {
                        _searchController.text = "";
                      });
                    },
                    child: Icon(
                      Feather.x,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                : SizedBox.shrink(),
            border: OutlineInputBorder(
              borderRadius: borderRadius15,
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: borderRadius15,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: borderRadius15,
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: textFieldbackColor,
        appBar: appBar(),
        body: Column(
          children: [
            search(),
            _searchController.text.isNotEmpty
                ? Expanded(child: hasData(_searchResult))
                : FutureBuilder<List<Market>>(
                    future: Market().getAllMarkets(parametr: ({"limit": "$len"})).then((value) {
                      itemList.clear();
                      value.forEach((element) {
                        itemList.add(element);
                      });

                      return value;
                    }),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasError)
                        return NoDataErrorPage(
                          onTap: () {
                            setState(() {});
                          },
                        );
                      else if (snapshot.hasData) {
                        return Expanded(child: hasData(snapshot.data));
                      }
                      return spinKit();
                    })
          ],
        ),
      ),
    );
  }

  void searchByMarketName(String text) {
    _searchResult.clear();

    if (text.isEmpty) {
      _searchResult.clear();
      setState(() {});
      return;
    }
    itemList.forEach((market) {
      if (market.name.toLowerCase().contains(text))
        setState(() {
          _searchResult.add(market);
        });
    });
  }
}
