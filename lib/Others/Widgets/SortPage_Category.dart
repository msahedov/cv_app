import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/Empty_state_page.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/ProductCards/ListviewCard.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:e_commerce_app/Others/Routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../constants/widgets.dart';

class SortPage_Category extends StatefulWidget {
  const SortPage_Category({Key key, this.id, this.name}) : super(key: key);
  final int id;
  final String name;
  _SortPage_CategoryState createState() => _SortPage_CategoryState();
}

class _SortPage_CategoryState extends State<SortPage_Category> {
  int _subCategoryId, userId, selectedIndex = 0, valuee = 0, selectedIndexFilter = 0;
  bool filterOrSort = true, isOpen = false, listAndGridIcon = false;
  TextEditingController highestPrice = TextEditingController();
  TextEditingController lowestPrice = TextEditingController();

  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int uid = _prefs.getInt('uid');
    setState(() {
      userId = uid;
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
    {"name": "Iň Köp like alan", "index": 1, "sort": "-likeCount"},
    {"name": "Iň Köp Görülen", "index": 2, "sort": "-viewCount"},
    {"name": "Gymmatdan -> Arzana", "index": 3, "sort": "-price"},
    {"name": "Arzandan -> Gymmada", "index": 4, "sort": "price"}
  ];

  AutoSizeGroup group = AutoSizeGroup();

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
                      Feather.x,
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

                              filterOrSort = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
                            child: Row(
                              children: [
                                Icon(
                                  Feather.tag,
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

                              filterOrSort = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
                            child: Row(
                              children: [
                                Icon(
                                  Feather.truck,
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
                        //loading = false;
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

  sortBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            padding: EdgeInsets.all(28),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
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
                      onTap: () {
                        Navigator.pop(context);
                        return null;
                      },
                      child: Icon(
                        Feather.x,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    Text('Yzygiderlik', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: popPinsSemiBold)),
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
                    RadioListTile(
                        value: 4,
                        contentPadding: EdgeInsets.only(right: 25),
                        title: AutoSizeText(sort[4]["name"], group: group, presetFontSizes: [18, 16, 14, 12, 10], style: TextStyle(color: Colors.black, fontFamily: popPinsMedium)),
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
                    // loading = false;
                    selectedIndex = valuee;
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: kPrimaryColor,
                  elevation: 1,
                  child: AutoSizeText(
                    'Gözle',
                    maxLines: 1,
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
              InkWell(
                onTap: () {
                  filterBottomSheet();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/filter.svg',
                      color: kPrimaryColor_1,
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Filter',
                        style: TextStyle(fontSize: 18.0, color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                      ),
                    )
                  ],
                ),
              ),
              divider(),
              InkWell(
                onTap: () {
                  sortBottomSheet();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: kPrimaryColor_1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Yzygiderlik',
                        style: TextStyle(fontSize: 18.0, fontFamily: popPinsSemiBold, color: kPrimaryColor_1),
                      ),
                    )
                  ],
                ),
              ),
              divider(),
              InkWell(
                onTap: () {
                  setState(() {
                    listAndGridIcon = !listAndGridIcon;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      listAndGridIcon ? Icons.list : Feather.grid,
                      color: kPrimaryColor_1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        listAndGridIcon ? 'List' : 'Grid',
                        style: TextStyle(fontSize: 18.0, fontFamily: popPinsSemiBold, color: kPrimaryColor_1),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget gridView(int subcategoryId) {
    return FutureBuilder<List<Product>>(
        future: Product().getAllProducts(parametr: {"subCategoryId": "$subcategoryId"}),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return NoDataErrorPage(
              onTap: () {
                setState(() {});
              },
            );
          else if (snapshot.hasData) {
            return snapshot.data.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EmptyPage(
                      selectedIndex: 5,
                    ),
                  )
                : StaggeredGridView.countBuilder(
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
          }

          return Center(
            child: spinKit(),
          );
        });
  }

  Widget listView(int subcategoryId) {
    return FutureBuilder<List<Product>>(
        future: Product().getAllProducts(parametr: {"subCategoryId": subcategoryId}),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return NoDataErrorPage(
              onTap: () {
                setState(() {});
              },
            );
          else if (snapshot.hasData)
            return snapshot.data.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EmptyPage(
                      selectedIndex: 5,
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductProfile(
                                          productId: snapshot.data[index].id,
                                        )));
                          },
                          child: ListviewCard(
                            userId: userId,
                            product: snapshot.data[index],
                          ));
                    },
                  );
          return Center(
            child: spinKit(),
          );
        });
  }

  Widget subCategories(List<SubCategory> subcategories) {
    return Container(
      height: 70,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subcategories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _subCategoryId = subcategories[index].id;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
              child: Material(
                elevation: 2,
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(BorderSide(color: kPrimaryColor)), color: subcategories[index].id == _subCategoryId ? kPrimaryColor : Colors.white, borderRadius: borderRadius10),
                    child: AutoSizeText(
                      subcategories[index].name_tm,
                      stepGranularity: 2,
                      minFontSize: 18,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: popPinsSemiBold, color: kPrimaryColor_1),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
            ? FutureBuilder<Category>(
                future: Category().getCategoryById(widget.id),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError)
                    return hasError();
                  else if (snapshot.hasData) {
                    return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        color: textFieldbackColor,
                        child: Column(
                          children: [
                            snapshot.data.subcategories.length > 0 ? subCategories(snapshot.data.subcategories) : SizedBox.shrink(),
                            listAndGridIcon ? Expanded(child: listView(_subCategoryId)) : Expanded(child: gridView(_subCategoryId))
                          ],
                        ));
                  }
                  return listAndGridIcon ? shimmerProduct() : shimmerGrid();
                })
            : Center(
                child: spinKit(),
              ),
      ),
    ));
  }
}
