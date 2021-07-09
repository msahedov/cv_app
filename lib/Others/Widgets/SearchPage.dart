import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/productModel.dart';
import '../constants/constants.dart';
import '../constants/widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
///////////////////////////////////////////////////get More items////////////////////////////////////////////////////////////////////////
  var itemList = [];
  int len = 10;
  int maxValue = 0;
  void getMore() {
    Future.delayed(Duration(seconds: 2), () {
      len += 10;
      if (len > maxValue) len = maxValue;
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  void dispose() {
    getMore();
    super.dispose();
  }

  void initState() {
    super.initState();
    getUserData();
    Product().getAllProductsMaxValue().then((value) {
      maxValue = value;
      maxValue > len ? len = 10 : len = maxValue;
    });
  }

///////////////////////////////////////////////////get More items////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////sort items////////////////////////////////////////////////////////////////////////
  List paramets = [
    "-price",
    "price",
    "-viewCount",
    "-likeCount",
  ];
  int selectedIndex = 0;
  bool loading = false;
  List<Map<String, dynamic>> _filters = [
    {"name": "Gymmatdan -> Arzana", "isSelected": false},
    {"name": "Arzandan -> Gymmada", "isSelected": false},
    {"name": "Köp görülenler", "isSelected": false},
    {"name": "Köp halananlar", "isSelected": false},
  ];
  PreferredSizeWidget buildBottom(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: 60,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: FilterChip(
                    selectedColor: kPrimaryColor,
                    checkmarkColor: kPrimaryColor_1,
                    disabledColor: Colors.grey[100],
                    backgroundColor: kPrimaryColor,
                    padding: EdgeInsets.all(10),
                    showCheckmark: true,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius20),
                    label: Text(
                      _filters[index]["name"],
                      style: buttonTextStyle,
                    ),
                    selected: _filters[index]["isSelected"],
                    onSelected: (bool value) {
                      setState(() {
                        loading = false;
                        _filters[index]["isSelected"] = !_filters[index]["isSelected"];
                        selectedIndex = index;
                      });
                      _filters.forEach((element) {
                        if (element["name"] != _filters[index]["name"]) {
                          setState(() {
                            element["isSelected"] = false;
                          });
                        }
                      });
                    },
                  ),
                );
              }),
        ));
  }

///////////////////////////////////////////////////sort items////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////login get user id////////////////////////////////////////////////////////////////////////
  int uid;
  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int uid = _prefs.getInt('uid');
    setState(() {
      uid = uid;
    });
  }
///////////////////////////////////////////////////login get user id////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////search////////////////////////////////////////////////////////////////////////
  TextEditingController searchController = new TextEditingController();
  List<Product> _searchResult = [];
  void searchByProductName(String text) {
    _searchResult.clear();
    setState(() {});
    if (text.isEmpty) {
      _searchResult.clear();
      setState(() {});
      return;
    }
    itemList.forEach((product) {
      if (product.name.toLowerCase().contains(text))
        setState(() {
          _searchResult.add(product);
        });
    });
  }

///////////////////////////////////////////////////search////////////////////////////////////////////////////////////////////////

  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      leading: searchController.text.isNotEmpty
          ? IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                searchByProductName(searchController.text);
                _filters.forEach((element) {
                  setState(() {
                    element["isSelected"] = false;
                  });
                });
              })
          : IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      title: TextFormField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          setState(() {});
        },
        onChanged: (value) {
          if (value.isEmpty) {
            searchController.text = '';
            setState(() {});
          } else {
            searchByProductName(searchController.text);
          }
        },
        onEditingComplete: () {
          searchByProductName(searchController.text);
          _filters.forEach((element) {
            setState(() {
              element["isSelected"] = false;
            });
          });
        },
        style: TextStyle(fontFamily: popPinsRegular, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.zero,
          ),
          hintText: "Gözleg",
          hintStyle: TextStyle(fontFamily: popPinsRegular),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            searchController.clear();
            setState(() {});
          },
        ),
      ],
      bottom: buildBottom(context),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textFieldbackColor,
      appBar: appBar(),
      body: searchController.text.isNotEmpty
          ? StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: _searchResult.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ProductProfile(
                                    productId: _searchResult[index].id,
                                  )));
                    },
                    child: StaggeredCard(
                      product: _searchResult[index],
                    ));
              },
              staggeredTileBuilder: (index) => StaggeredTile.count(1, index.isEven ? 1.5 : 1.6),
            )
          : FutureBuilder<List<Product>>(
              future: Product().getAllProducts(parametr: ({"sort": paramets[selectedIndex], "limit": "$len"})).then((value) {
                itemList.clear();
                loading = true;
                print(loading);
                value.forEach((element) {
                  itemList.add(element);
                });
                return value;
              }),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return NoDataErrorPage(
                    onTap: () {
                      setState(() {});
                    },
                  );
                else if (snapshot.hasData) {
                  return loading
                      ? StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: itemList.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (maxValue > len) {
                              if (index + 1 == itemList.length) {
                                getMore();
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: spinKit(),
                                );
                              }
                            }
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => ProductProfile(
                                                productId: itemList[index].id,
                                              )));
                                  return null;
                                },
                                child: StaggeredCard(
                                  product: itemList[index],
                                ));
                          },
                          staggeredTileBuilder: (index) => StaggeredTile.count(1, index.isEven ? 1.5 : 1.6),
                        )
                      : Center(child: spinKit());
                } else
                  return Center(child: spinKit());
              }),
    );
  }
}
