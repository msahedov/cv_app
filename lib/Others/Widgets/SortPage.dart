import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:e_commerce_app/Others/Routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../constants/widgets.dart';

class SortPage extends StatefulWidget {
  const SortPage({Key key, this.name, this.params}) : super(key: key);
  final String name;
  final Map<String, String> params;
  _SortPageState createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  int userIDD, selectedIndex = 0, valuee = 0, selectedIndexFilter = 0;
  AutoSizeGroup group = AutoSizeGroup();
  TextEditingController highestPrice = new TextEditingController(), lowestPrice = new TextEditingController();
  bool isOpen = false;
  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int uid = _prefs.getInt('uid');
    setState(() {
      userIDD = uid;
    });
  }

  void initState() {
    super.initState();
    getUserData();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        isOpen = true;
      });
    });
  }

  List<Map<String, dynamic>> sort = [
    {"name": "Iň Täzeleri", "index": 0, "sort": "-createdAt"},
    {"name": "Iň Köp Görülen", "index": 1, "sort": "-viewCount"},
    {"name": "Gymmatdan -> Arzana", "index": 2, "sort": "-price"},
    {"name": "Arzandan -> Gymmada", "index": 3, "sort": "price"}
  ];

  sortBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            padding: EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Wrap(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        FeatherIcons.x,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    Text('Tertiplemek', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: popPinsSemiBold)),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
              StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                        value: 0,
                        contentPadding: EdgeInsets.only(right: 25),
                        title: AutoSizeText(sort[0]["name"], group: group, presetFontSizes: [18, 16, 14, 12, 10], style: TextStyle(color: Colors.black, fontFamily: popPinsMedium)),
                        groupValue: valuee,
                        activeColor: kPrimaryColor_1,
                        onChanged: (int index) {
                          setState(() {
                            valuee = index;
                          });
                        }),
                    RadioListTile(
                        value: 1,
                        contentPadding: EdgeInsets.only(right: 25),
                        title: AutoSizeText(sort[1]["name"], group: group, presetFontSizes: [18, 16, 14, 12, 10], style: TextStyle(color: Colors.black, fontFamily: popPinsMedium)),
                        groupValue: valuee,
                        activeColor: kPrimaryColor_1,
                        onChanged: (int index) {
                          setState(() {
                            valuee = index;
                          });
                        }),
                    RadioListTile(
                        value: 2,
                        contentPadding: EdgeInsets.only(right: 25),
                        title: AutoSizeText(sort[2]["name"], group: group, presetFontSizes: [18, 16, 14, 12, 10], style: TextStyle(color: Colors.black, fontFamily: popPinsMedium)),
                        groupValue: valuee,
                        activeColor: kPrimaryColor_1,
                        onChanged: (int index) {
                          setState(() {
                            valuee = index;
                          });
                        }),
                    RadioListTile(
                        value: 3,
                        contentPadding: EdgeInsets.only(right: 25),
                        title: AutoSizeText(sort[3]["name"], group: group, presetFontSizes: [18, 16, 14, 12, 10], style: TextStyle(color: Colors.black, fontFamily: popPinsMedium)),
                        groupValue: valuee,
                        activeColor: kPrimaryColor_1,
                        onChanged: (int index) {
                          setState(() {
                            valuee = index;
                          });
                        }),
                  ],
                );
              }),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    setState(() {
                      selectedIndex = valuee;
                      // queryParams.addAll({"sort": sort[selectedIndex]["sort"]});
                    });
                    Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: kPrimaryColor,
                  elevation: 1,
                  child: AutoSizeText(
                    'Tertiple',
                    maxLines: 1,
                    group: group,
                    maxFontSize: 24,
                    minFontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kPrimaryColor_1, fontSize: 50, fontFamily: popPinsSemiBold),
                  ),
                ),
              ),
            ]));
      },
    );
  }

  List<bool> filterTick = [
    false,
    false,
  ];

  List<Map<String, dynamic>> filter = [
    {"name": "price[between]", "sort": "5;10}"},
    {"name": "sort", "sort": "-discount"},
    {"name": "sort", "sort": "-brand"},
  ];

  filterBottomSheet() {
    highestPrice.clear();
    lowestPrice.clear();
    filterTick[0] = false;
    filterTick[1] = false;
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
            padding: EdgeInsets.all(28),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Wrap(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      return null;
                    },
                    child: Icon(
                      FeatherIcons.x,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                  Text('Filter', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: popPinsSemiBold)),
                  InkWell(
                    child: Text(
                      'Arassala',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black, fontFamily: popPinsMedium),
                    ),
                    onTap: () {
                      setState(() {
                        highestPrice.clear();
                        lowestPrice.clear();
                      });
                    },
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Baha Aralygy',
                  style: TextStyle(color: Colors.black, fontFamily: popPinsMedium),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Container(
                      width: ((size.width / 2) - 55),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black12, width: 1)),
                      child: TextField(
                        controller: highestPrice,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration:
                            InputDecoration(contentPadding: EdgeInsets.all(20), hintText: 'Iň Arzan', hintStyle: TextStyle(color: Colors.black26, fontFamily: popPinsMedium), border: InputBorder.none),
                      ),
                    ),
                    Container(
                      width: 15,
                      height: 1,
                      color: Colors.black38,
                    ),
                    Container(
                      width: ((size.width / 2) - 55),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black12, width: 1)),
                      child: TextField(
                        controller: lowestPrice,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20), hintText: 'Iň Gymmat', hintStyle: TextStyle(color: Colors.black26, fontFamily: popPinsMedium), border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Filter ',
                  style: TextStyle(fontSize: 18, fontFamily: popPinsMedium),
                ),
              ),
              Column(
                children: [
                  Container(child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndexFilter = 1;
                              filterTick[0] = !filterTick[0];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
                            child: Row(
                              children: [
                                Icon(
                                  FeatherIcons.tag,
                                  color: kPrimaryColor_1,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    'Arzanladyş',
                                    presetFontSizes: [16, 14, 12, 10, 8],
                                    style: TextStyle(fontFamily: popPinsRegular),
                                  ),
                                )),
                                filterTick[0]
                                    ? Icon(
                                        Icons.check,
                                        color: kPrimaryColor_1,
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndexFilter = 2;
                              filterTick[1] = !filterTick[1];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
                            child: Row(
                              children: [
                                Icon(
                                  FeatherIcons.truck,
                                  color: kPrimaryColor_1,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    'Eltip berme MUGT',
                                    presetFontSizes: [16, 14, 12, 10, 8],
                                    style: TextStyle(fontFamily: popPinsRegular),
                                  ),
                                )),
                                filterTick[1]
                                    ? Icon(
                                        Icons.check,
                                        color: kPrimaryColor_1,
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {
                        if (highestPrice.text.isNotEmpty && lowestPrice.text.isNotEmpty) {
                          selectedIndexFilter = 0;
                        }

                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: kPrimaryColor,
                      elevation: 1,
                      child: AutoSizeText(
                        'Gözle',
                        maxLines: 1,
                        presetFontSizes: [24, 22, 20, 18, 16, 14],
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                      ),
                    ),
                  ),
                ],
              )
            ])));
  }

//others

  Widget sortItems() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            child: Divider(
              color: Colors.grey.shade200,
              thickness: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    filterBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/filter.svg',
                        color: kPrimaryColor_1,
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Süzgüç',
                          style: TextStyle(fontSize: 18.0, color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              divider(),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    sortBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: kPrimaryColor_1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Tertiplemek',
                          style: TextStyle(fontSize: 18.0, fontFamily: popPinsSemiBold, color: kPrimaryColor_1),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget gridView(List<Product> products) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 4.8,
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProductProfile(
                            productId: products[index].id,
                          )));
              return null;
            },
            child: StaggeredCard(
              product: products[index],
            ));
      },
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

  Widget sliverAppBar() {
    return SliverAppBar(
      toolbarHeight: 60,
      elevation: 2,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        widget.name,
        textAlign: TextAlign.end,
        style: TextStyle(
          height: 1.5,
          color: Colors.black,
          fontFamily: popPinsSemiBold,
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, searchpage);
            },
            child: Padding(padding: EdgeInsets.only(right: 20), child: SvgPicture.asset('assets/icons/search.svg', color: kPrimaryColor_1))),
      ],
      leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor_1,
              ))),
      pinned: true,
    );
  }

//others
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            sliverAppBar(),
            SliverToBoxAdapter(
              child: sortItems(),
            )
          ];
        },
        body: isOpen
            ? FutureBuilder<List<Product>>(
                future: Product().getAllProducts(parametr: widget.params),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError)
                    return hasError();
                  else if (snapshot.hasData) {
                    return Container(width: double.infinity, height: MediaQuery.of(context).size.height, color: textFieldbackColor, child: gridView(snapshot.data));
                  }
                  return Center(
                    child: spinKit(),
                  );
                })
            : Center(
                child: spinKit(),
              ),
      ),
    ));
  }
}
