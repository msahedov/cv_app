import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:e_commerce_app/Others/Widgets/SortPage.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class Listview extends StatefulWidget {
  @override
  _ListviewState createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
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
    return Column(
      children: [
        listName(AppLocalizations.of(context).newProducts, () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => SortPage(
                    params: {"sort": "-createdAt"},
                    name: AppLocalizations.of(context).newProducts,
                  )));
        }, context),
        StreamBuilder<List<Product>>(
            stream: Product().getAllProducts(parametr: {"limit": "10", "sort": "-createdAt"}).asStream(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError)
                return hasError();
              else if (snapshot.hasData) {
                return Container(
                  height: 300,
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (_) => ProductProfile(
                                    productId: snapshot.data[index].id,
                                  )));
                        },
                        child: Container(
                          width: 200,
                          height: 300,
                          child: StaggeredCard(
                            product: snapshot.data[index],
                          ),
                        ),
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
