import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/wishlist/wishlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class WishListTab extends StatefulWidget {
  const WishListTab({Key key}) : super(key: key);

  @override
  _WishListTabState createState() => _WishListTabState();
}

class _WishListTabState extends State<WishListTab> {
  double _screenWidth, _screenHeight;
  ScrollController _videosScrollController = ScrollController();
  final youtubeUrl = 'https://www.youtube.com/watch?v=';

  @override
  void initState() {
    super.initState();
    context.read<WishListBloc>().add(GetWishListItems());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _videosScrollController,
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          width: _screenWidth,
          child: BlocBuilder<WishListBloc, WishListState>(
            builder: (context, state) {
              if (state is FailedToGetWishListItems) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/splash/undraw_empty.png',
                          width: _screenWidth * 0.8),
                      Text(
                        'لا يوجد شئ في المفضلة!',
                        style: TextStyle(
                            color: mPrimaryBlackColor, fontFamily: 'Arb'),
                      ),
                    ],
                  ),
                );
              }
              if (state is GetWishListItemStateDone) {
                final listOfWishList = state.wishlist;
                return ListView.builder(
                    itemCount: listOfWishList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => VideoItemWidget(
                        video: listOfWishList[index],
                        index: index,
                        isFavourite: true));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
