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
  TextEditingController _searchController = TextEditingController();

  Widget hasData(List<Market> markets) {
    return ListView.builder(
      itemCount: markets.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MarketProfilePage(marketID: markets[index].id))),
            child: MarketCard(
              market: markets[index],
            ));
      },
    );
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
            Icons.arrow_back_ios_sharp,
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
          onChanged: (text) {},
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
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _searchController.text = "";
                });
              },
              child: Icon(
                Feather.x,
                color: Colors.black,
                size: 20,
              ),
            ),
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
            FutureBuilder<List<Market>>(
                future: Market().getAllMarkets(),
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
                  return Expanded(child: Center(child: spinKit()));
                })
          ],
        ),
      ),
    );
  }
}
