// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/home/home.dart';

import 'helpers/helpers.dart';
import 'masaqat/masaqat.dart';

class MainPage extends StatefulWidget {
  final int pageIndex;
  final String countryName;
  const MainPage({this.pageIndex, this.countryName});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    if (widget.pageIndex == null) {
      setState(() => _selectedIndex = 0);
    } else {
      setState(() => _selectedIndex = widget.pageIndex);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: mSecondaryColor,
          title: Container(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset('assets/logo.png',
                          height: 30, width: 30, fit: BoxFit.fill)),
                  SizedBox(width: 8),
                  Text('${_renderTitleOfAppBar()}',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Arb',
                          color: Colors.black)),

                ],
              )),
        ),
        bottomNavigationBar: Container(
          height: 60.0,
          width: size.width,
          child: BottomAppBar(
            elevation: 1.0,
            color: mSecondaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                // Home
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _selectedIndex == 0
                            ? ImageIcon(
                          AssetImage('assets/icons/fire.png'),
                          size: 25.0,
                        )
                            : ImageIcon(
                          AssetImage('assets/icons/fire (1).png'),
                          size: 25.0,
                        ),
                        SizedBox(height: 3),
                        Text(
                          'الرئيسية',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Arb',
                              color: _selectedIndex == 0
                                  ? mPrimaryBlackColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),

                // Playlist
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _selectedIndex == 1
                            ? ImageIcon(
                          AssetImage('assets/icons/playlist.png'),
                          size: 25.0,
                        )
                            : ImageIcon(
                          AssetImage('assets/icons/playlist (1).png'),
                          size: 25.0,
                        ),
                        SizedBox(height: 3),
                        Text(
                          'المساقات',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Arb',
                              color: _selectedIndex == 1
                                  ? mPrimaryBlackColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),


                // Favourite
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _pageController.animateToPage(
                        2,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _selectedIndex == 2
                            ? ImageIcon(
                          AssetImage('assets/icons/heart.png'),
                          size: 25.0,
                        )
                            : ImageIcon(
                          AssetImage('assets/icons/heart (1).png'),
                          size: 25.0,
                        ),
                        SizedBox(height: 3),
                        Text(
                          'المفضلة',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Arb',
                              color: _selectedIndex == 2
                                  ? mPrimaryBlackColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),




              ],
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeTab(),
            MasaqatTab(),
            HomeTab(),
          ],
        ),
      ),
    );
  }

  String _renderTitleOfAppBar() {
    switch (_selectedIndex) {
      case 0:
        return 'تعلموا بالعربية';
        break;
      case 1:
        return 'قوائم التشغيل';
        break;
      case 2:
        return 'المفضلة';
        break;
      default:
        return 'تعلموا بالعربية';
    }
  }
}
