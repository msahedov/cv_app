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
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  PageController _bottonPageController = new PageController();
  List<Widget> _pages;
  int _selectedPage;

  @override
  void initState() {
    super.initState();
    _selectedPage = 0;
    _pages = <Widget>[HomePage(), CategoryPage(), CartPage(), FavoritesPage(), ProfilPage()];
  }

  Widget build(BuildContext context) {
    final _items = [
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
    ];

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _selectedPage,
            height: 50.0,
            items: _items,
            color: kPrimaryColor_1,
            buttonBackgroundColor: kPrimaryColor_1,
            backgroundColor: textFieldbackColor,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              _bottonPageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
            letIndexChange: (index) => true,
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _bottonPageController,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _selectedPage = index;
              });
            },
          )),
    );
  }
}
