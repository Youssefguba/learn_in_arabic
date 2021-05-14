import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/main_screen.dart';
import 'package:learn_in_arabic/navigator/named_navigator_impl.dart';
import 'package:learn_in_arabic/navigator/navigator.dart';

import '../../helpers/helpers.dart';
import '../on_boarding.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key key}) : super(key: key);
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentPage = 0;
  PageController _boardingController = PageController();

  List<Map<String, String>> _splashData = [
    {
      "text": "تعلموا بالعربية من الطلاب إلى الطلاب!",
      "image": "assets/splash/undraw_education.svg"
    },
    {
      "text": "يمكنك تعلم آخر ما توصل إليه العالم من التكنولوجيا من خلال تعلموا بالعربية",
      "image": "assets/splash/undraw_online_learning.svg"
    },
    {
      "text": "جميع ما تحتاج إليه كطالب ستجده معنا!",
      "image": "assets/splash/undraw_social.svg"
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 9,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _boardingController,
                  onPageChanged: (value) => setState(() => _currentPage = value),
                  itemCount: _splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: _splashData[index]["text"],
                    image: _splashData[index]["image"],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _splashData.length,
                      (index) => dotCircles(index),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  child: _currentPage == 2
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: ButtonLabel(
                            onPressed: () {
                              NamedNavigatorImpl().push(Routes.SIGN_UP);
                            },
                            text: 'هيا نبدأ!',
                            color: mPrimaryBlackColor,
                          ),
                        )
                      : Container(
                        alignment: Alignment.bottomCenter,
                        width: width * 0.9,
                        child: ButtonLabel(
                          onPressed: () => setState(() =>
                              _boardingController.jumpToPage(_currentPage += 1)),
                          text: 'التالي',

                          color: mPrimaryBlackColor,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer dotCircles(int index) {
    return AnimatedContainer(
      duration: mAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6.0,
      width: _currentPage == index ? 20.0 : 6.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? mPrimaryBlueColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
