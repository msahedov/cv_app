import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/Empty_state_page.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/productModel.dart';
import '../constants/constants.dart';
import '../constants/widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = new TextEditingController();
  int uid;
  // List paramets = [
  //   "-price",
  //   "price",
  //   "-viewCount",
  //   "-likeCount",
  // ];
  // int selectedIndex = 0;

  // List<Map<String, dynamic>> _filters = [
  //   {"name": "Gymmatdan -> Arzana", "isSelected": false},
  //   {"name": "Arzandan -> Gymmada", "isSelected": false},
  //   {"name": "Köp görülenler", "isSelected": false},
  //   {"name": "Köp halananlar", "isSelected": false},
  // ];
  // PreferredSizeWidget buildBottom(BuildContext context) {
  //   return PreferredSize(
  //       preferredSize: Size.fromHeight(60),
  //       child: AnimatedContainer(
  //         duration: Duration(milliseconds: 500),
  //         height: 60,
  //         child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: 4,
  //             itemBuilder: (context, index) {
  //               return Padding(
  //                 padding: EdgeInsets.all(4.0),
  //                 child: FilterChip(
  //                   selectedColor: kPrimaryColor,
  //                   checkmarkColor: kPrimaryColor_1,
  //                   disabledColor: Colors.grey[100],
  //                   backgroundColor: kPrimaryColor,
  //                   padding: EdgeInsets.all(10),
  //                   showCheckmark: true,
  //                   shape: RoundedRectangleBorder(borderRadius: borderRadius20),
  //                   label: Text(
  //                     _filters[index]["name"],
  //                     style: buttonTextStyle,
  //                   ),
  //                   selected: _filters[index]["isSelected"],
  //                   onSelected: (bool value) {
  //                     setState(() {
  //                       _filters[index]["isSelected"] = !_filters[index]["isSelected"];
  //                       selectedIndex = index;
  //                     });
  //                     _filters.forEach((element) {
  //                       if (element["name"] != _filters[index]["name"]) {
  //                         setState(() {
  //                           element["isSelected"] = false;
  //                         });
  //                       }
  //                     });
  //                   },
  //                 ),
  //               );
  //             }),
  //       ));
  // }

  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int uid = _prefs.getInt('uid');
    setState(() {
      uid = uid;
    });
  }

  void initState() {
    super.initState();
    getUserData();
    searchController.addListener(() => setState(() {}));
  }

  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor_1),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: TextFormField(
        controller: searchController,
        textInputAction: TextInputAction.search,
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
            color: kPrimaryColor_1,
          ),
          onPressed: () {
            searchController.clear();
          },
        ),
      ],
      //  bottom: buildBottom(context),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textFieldbackColor,
      appBar: appBar(),
      body: FutureBuilder<List<Product>>(
          future: Product().getAllProducts(parametr: ({"q": "${searchController.text}"})),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return NoDataErrorPage(
                onTap: () {
                  setState(() {});
                },
              );
            else if (snapshot.hasData) {
              return snapshot.data.isEmpty
                  ? EmptyPage(
                      selectedIndex: 5,
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 4.8),
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
                    );
            } else
              return Center(child: spinKit());
          }),
    );
  }
}
