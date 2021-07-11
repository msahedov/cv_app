import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/Profile%20Page/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'Cart Page/Cart.dart';
import 'Category Page/Category.dart';
import 'Favorites Page/Favorites.dart';
import 'Home Page/HomePage.dart';
import 'Others/constants/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
  GlobalKey _bottomNavigationKey = GlobalKey();
  PageController _bottonPageController = new PageController();
  TabController _tabController;
  int _selectedPage;

  @override
  void initState() {
    super.initState();
    _selectedPage = 0;
    _tabController = new TabController(length: 5, vsync: this);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _selectedPage,
          height: 50.0,
          items: [
            Icon(
              AntDesign.home,
              color: _selectedPage == 0 ? kPrimaryColor : Colors.white,
              size: _selectedPage == 0 ? 32 : 28,
            ),
            Icon(
              Feather.grid,
              color: _selectedPage == 1 ? kPrimaryColor : Colors.white,
              size: _selectedPage == 1 ? 32 : 28,
            ),
            Icon(
              Feather.shopping_bag,
              color: _selectedPage == 2 ? kPrimaryColor : Colors.white,
              size: _selectedPage == 2 ? 32 : 28,
            ),
            Icon(
              Feather.heart,
              color: _selectedPage == 3 ? kPrimaryColor : Colors.white,
              size: _selectedPage == 3 ? 32 : 28,
            ),
            Icon(
              FontAwesome.user_o,
              color: _selectedPage == 4 ? kPrimaryColor : Colors.white,
              size: _selectedPage == 4 ? 32 : 28,
            ),
          ],
          color: kPrimaryColor_1,
          buttonBackgroundColor: kPrimaryColor_1,
          backgroundColor: textFieldbackColor,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {
            _tabController.animateTo(index);
            setState(() {
              _selectedPage = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [HomePage(), CategoryPage(), CartPage(), FavoritesPage(), ProfilPage()],
        ),
      ),
    );
  }
}
