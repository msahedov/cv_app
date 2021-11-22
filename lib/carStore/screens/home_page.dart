import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../objects/car_item_object.dart';
import 'car_detail_screen.dart';
import 'order_screen.dart';
import 'login_screen.dart';
import 'package:flutter/cupertino.dart';
import '../constants/page_routs.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int selectedPage = 0;
  TabController _tabController;
  PageController _pageController0;
  PageController _pageController1;
  PageController _pageController2;
  PageController _pageController3;
  PageController _pageController4;
  PageController _pageController5;
  PageController _pageController6;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isSearching = false;

  List<List<CarItemObject>> cars = [
    //Sedan
    [
      CarItemObject(
          imageName: "assets/images/bmw_sedan.png",
          carName: "BMW sedan",
          description:
              "BMW 8 Series. The BMW 8 Series is a range of grand tourers produced by BMW. The 8 Series was introduced in 1990 under the E31 model code and was only available as a two-door coupé. ... The G15 8 Series introduces an inline-six diesel engine, and a high-performance M8 model is also expected to be launched in the future.",
          backgroudColor: Colors.black),
      CarItemObject(
          imageName: "assets/images/fiat_sedan.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/honda_sedan.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/honda.png",
          carName: "Honda sedan",
          description:
              "Honda Civic. ... EPA guidelines for vehicle size class stipulate a car having combined passenger and cargo room of 110 to 119.9 cubic feet (3,110 to 3,400 L) is considered a mid-size car, and as such the tenth generation Civic sedan is technically a small-end mid-size car, although it still competes in the compact class.",
          backgroudColor: Colors.purple),
    ],
    //Hatchback
    [
      CarItemObject(
          imageName: "assets/images/hatchback.png",
          carName: "MAZDA",
          description:
              "Mazda. The Mazda is a range of grand tourers produced by Mazda. The 8 Series was introduced in 1990 under the E31 model code and was only available as a two-door coupé. ... The G15 8 Series introduces an inline-six diesel engine, and a high-performance M8 model is also expected to be launched in the future.",
          backgroudColor: Colors.black),
      CarItemObject(
          imageName: "assets/images/hatcback2.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
    ],
    //MPV
    [
      CarItemObject(
          imageName: "assets/images/mpv1.png",
          carName: "BMW ",
          description:
              "BMW 8 Series. The BMW 8 Series is a range of grand tourers produced by BMW. The 8 Series was introduced in 1990 under the E31 model code and was only available as a two-door coupé. ... The G15 8 Series introduces an inline-six diesel engine, and a high-performance M8 model is also expected to be launched in the future.",
          backgroudColor: Colors.black),
      CarItemObject(
          imageName: "assets/images/mpv2.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/mpv3.png",
          carName: "Honda",
          description:
              "Honda Civic. ... EPA guidelines for vehicle size class stipulate a car having combined passenger and cargo room of 110 to 119.9 cubic feet (3,110 to 3,400 L) is considered a mid-size car, and as such the tenth generation Civic sedan is technically a small-end mid-size car, although it still competes in the compact class.",
          backgroudColor: Colors.purple),
    ],
    //SUV
    [
      CarItemObject(
          imageName: "assets/images/suv1.png",
          carName: "Mercedes",
          description:
              "Mercedes 8 Series. The BMW 8 Series is a range of grand tourers produced by BMW. The 8 Series was introduced in 1990 under the E31 model code and was only available as a two-door coupé. ... The G15 8 Series introduces an inline-six diesel engine, and a high-performance M8 model is also expected to be launched in the future.",
          backgroudColor: Colors.black),
      CarItemObject(
          imageName: "assets/images/suv2.png",
          carName: "Fiat ",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/suv3.png",
          carName: "Mazda",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/suv5.png",
          carName: "Honda ",
          description:
              "Honda Civic. ... EPA guidelines for vehicle size class stipulate a car having combined passenger and cargo room of 110 to 119.9 cubic feet (3,110 to 3,400 L) is considered a mid-size car, and as such the tenth generation Civic sedan is technically a small-end mid-size car, although it still competes in the compact class.",
          backgroudColor: Colors.purple),
    ],
    //Crossover
    [
      CarItemObject(
          imageName: "assets/images/hundai_cross.png",
          carName: "Hundai",
          description:
              "Hundai is a range of grand tourers produced by BMW. The 8 Series was introduced in 1990 under the E31 model code and was only available as a two-door coupé. ... The G15 8 Series introduces an inline-six diesel engine, and a high-performance M8 model is also expected to be launched in the future.",
          backgroudColor: Colors.black),
      CarItemObject(
          imageName: "assets/images/nissan_crossover.png",
          carName: "Nissan",
          description:
              "The Nissan sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/hundai_crossover.png",
          carName: "Hundai",
          description:
              "The Hundai Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/bmv_crossover.png",
          carName: "BMW",
          description:
              "BMW ... EPA guidelines for vehicle size class stipulate a car having combined passenger and cargo room of 110 to 119.9 cubic feet (3,110 to 3,400 L) is considered a mid-size car, and as such the tenth generation Civic sedan is technically a small-end mid-size car, although it still competes in the compact class.",
          backgroudColor: Colors.purple),
    ],
    //Coupe
    [
      CarItemObject(
          imageName: "assets/images/coupe1.png",
          carName: "BMW sedan",
          description:
              "BMW 8 Series. The BMW 8 Series is a range of grand tourers produced by BMW. The 8 Series was introduced in 1990 under the E31 model code and was only available as a two-door coupé. ... The G15 8 Series introduces an inline-six diesel engine, and a high-performance M8 model is also expected to be launched in the future.",
          backgroudColor: Colors.black),
      CarItemObject(
          imageName: "assets/images/coupe2.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/coupe3.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
    ],
    //Convertible
    [
      CarItemObject(
          imageName: "assets/images/convertible1.png",
          carName: "BMW sedan",
          description:
              "BMW 8 Series. The BMW 8 Series is a range of grand tourers produced by BMW. The 8 Series was introduced in 1990 under the E31 model code and was only available as a two-door coupé. ... The G15 8 Series introduces an inline-six diesel engine, and a high-performance M8 model is also expected to be launched in the future.",
          backgroudColor: Colors.black),
      CarItemObject(
          imageName: "assets/images/convertible2.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
      CarItemObject(
          imageName: "assets/images/convertible3.png",
          carName: "Fiat sedan",
          description:
              "The Fiat Tipo sedan is 4532 mm long, 1497 mm tall and 1792 mm wide with a wheelbase of 2638 mm and a five-seat passenger compartment with a 520-litre trunk. The hatchback has the same wheelbase but the bodywork is 4368 mm long, 1495 mm tall and 1792 mm wide. The trunk has a capacity of 440 litres.",
          backgroudColor: Colors.red),
    ]
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 7, vsync: this);
    _pageController0 = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController1 = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController2 = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController3 = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController4 = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController5 = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController6 = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _makeOrder() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => OrderScreen()));
  }

  _logOut() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  _searchPressed() {
    isSearching = !isSearching;
    setState(() {});
  }

  Widget _carSelector(PageController _pageController, int index, List<CarItemObject> _cars) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500,
            width: Curves.easeInOut.transform(value) * 400,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, FadeRoute(page: CarDetailScreen(car: _cars[selectedPage])));
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 400,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.grey], stops: [0, 1]), borderRadius: BorderRadius.circular(25)),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: _cars[index].imageName,
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(_cars[index].imageName),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "starting at",
                          style: TextStyle(fontFamily: titleFont, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(_cars[index].carPrice, style: TextStyle(fontFamily: descFont, color: Colors.white)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      children: <Widget>[
                        Text(_cars[index].carName, style: TextStyle(fontFamily: titleFont, color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: RawMaterialButton(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.add_shopping_cart,
                  size: 30,
                  color: Colors.white,
                ),
                fillColor: Colors.black,
                shape: CircleBorder(),
                elevation: 2.0,
                onPressed: () => _makeOrder(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _mainWidgetSwitcher(bool isSearching) {
    return !isSearching
        ? Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    tag: "drawer_button",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(icon: Icon(Icons.menu, size: 30), onPressed: () => _scaffoldKey.currentState.openDrawer()),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          ),
                          onPressed: () => _searchPressed()))
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "Best cars",
                  style: TextStyle(fontFamily: titleFont, fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.6),
                labelPadding: EdgeInsets.symmetric(horizontal: 35),
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "Sedan",
                      style: TextStyle(fontFamily: descFont, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Hatchback",
                      style: TextStyle(fontFamily: descFont, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "MPV",
                      style: TextStyle(fontFamily: descFont, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "SUV",
                      style: TextStyle(fontFamily: descFont, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Crossover",
                      style: TextStyle(fontFamily: descFont, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Coupe",
                      style: TextStyle(fontFamily: descFont, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Convertible",
                      style: TextStyle(fontFamily: descFont, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 450,
                width: double.infinity,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    //Sedan
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController0,
                        onPageChanged: (int index) {
                          setState(() {
                            this.selectedPage = index;
                          });
                        },
                        itemCount: cars[0].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _carSelector(_pageController0, index, cars[0]);
                        },
                      ),
                    ),

                    //Hatchback
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController1,
                        onPageChanged: (int index) {
                          setState(() {
                            this.selectedPage = index;
                          });
                        },
                        itemCount: cars[1].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _carSelector(_pageController1, index, cars[1]);
                        },
                      ),
                    ),

                    //MPV
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController2,
                        onPageChanged: (int index) {
                          setState(() {
                            this.selectedPage = index;
                          });
                        },
                        itemCount: cars[2].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _carSelector(_pageController2, index, cars[2]);
                        },
                      ),
                    ),

                    //SUV
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController3,
                        onPageChanged: (int index) {
                          setState(() {
                            this.selectedPage = index;
                          });
                        },
                        itemCount: cars[3].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _carSelector(_pageController3, index, cars[3]);
                        },
                      ),
                    ),

                    //Crossover
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController4,
                        onPageChanged: (int index) {
                          setState(() {
                            this.selectedPage = index;
                          });
                        },
                        itemCount: cars[4].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _carSelector(_pageController4, index, cars[4]);
                        },
                      ),
                    ),

                    //Coupe
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController5,
                        onPageChanged: (int index) {
                          setState(() {
                            this.selectedPage = index;
                          });
                        },
                        itemCount: cars[5].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _carSelector(_pageController5, index, cars[5]);
                        },
                      ),
                    ),

                    //Convertible
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController6,
                        onPageChanged: (int index) {
                          setState(() {
                            this.selectedPage = index;
                          });
                        },
                        itemCount: cars[6].length,
                        itemBuilder: (BuildContext context, int index) {
                          return _carSelector(_pageController6, index, cars[6]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description:", style: TextStyle(fontWeight: FontWeight.w900, fontFamily: descFont, fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cars[0][selectedPage].description,
                  style: TextStyle(fontFamily: descFont, fontSize: 18),
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: TextStyle(fontFamily: descFont, fontSize: 18),
                        onSubmitted: (String text) {
                          if (text.length == 0) {
                            _searchPressed();
                          }
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                            prefixIcon: BackButton(
                              color: Colors.black,
                              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage())),
                            ),
                            border: InputBorder.none,
                            hintText: 'Look for cars',
                            hintStyle: TextStyle(fontFamily: descFont, fontSize: 20)),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          ),
                          onPressed: () => _searchPressed())),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CarDetailScreen(car: cars[0][selectedPage])));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 20),
                  child: Container(width: double.infinity, child: Text("BMW 2021", style: TextStyle(fontFamily: titleFont, fontSize: 20))),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CarDetailScreen(car: cars[0][selectedPage])));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 20),
                  child: Container(width: double.infinity, child: Text("Mercedes Benz", style: TextStyle(fontFamily: titleFont, fontSize: 20))),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CarDetailScreen(car: cars[0][selectedPage])));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 20),
                  child: Container(width: double.infinity, child: Text("Highlander 2019", style: TextStyle(fontFamily: titleFont, fontSize: 20))),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            width: double.infinity,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[AnimatedSwitcher(duration: Duration(milliseconds: 300), child: _mainWidgetSwitcher(isSearching))],
                ),
              ),
            ),
          ), // This
          drawer: Drawer(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.lightBlue, Colors.orange], stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SafeArea(
                  child: Stack(
                children: <Widget>[
                  Hero(
                    tag: "drawer_button",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: IconButton(icon: Icon(Icons.arrow_back, size: 30), onPressed: () => Navigator.of(context).pop()),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: Container(
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/app_logo.jpg"))),
                        width: double.infinity,
                        height: 250,
                      )),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(child: Text("View profile", style: TextStyle(color: Colors.white, fontFamily: descFont, fontWeight: FontWeight.w700, fontSize: 20))),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(child: Text("About us", style: TextStyle(color: Colors.white, fontFamily: descFont, fontWeight: FontWeight.w700, fontSize: 20))),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(child: Text("Logout", style: TextStyle(color: Colors.white, fontFamily: descFont, fontWeight: FontWeight.w700, fontSize: 20))),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook,
                                size: 45,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.instagram,
                                  size: 40,
                                  color: Colors.indigo,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.youtube,
                                  color: Colors.red,
                                  size: 40,
                                ))
                          ]),
                        ),
                      )
                    ],
                  ),
                ],
              )),
            ),
          ) // trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
