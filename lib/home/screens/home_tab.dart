import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/helpers/widgets/video_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  double _screenWidth, _screenHeight;
  RefreshController _refreshController = RefreshController();
  ScrollController _videosScrollController = ScrollController();
  final youtubeUrl = 'https://www.youtube.com/watch?v=';
  bool _isFavouritePressed = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeContentBloc>().add(GetHomePlaylistEvent(null));
    _videosScrollController.addListener(() {
      context.read<HomeContentBloc>().scrollListener(_videosScrollController);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: SingleChildScrollView(
        controller: _videosScrollController,
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          width: _screenWidth,
          child: BlocBuilder<HomeContentBloc, HomeContentState>(
            builder: (context, state) {
              if (state is LoadingToGetHomeContent) {
                return HomeVideosShimmerWidget();
              }
              if (state is GetHomeContentStateDone) {
                final listOfVideos = state.listOfVideos;
                listOfVideos.shuffle();

                return ListView.builder(
                  itemCount: listOfVideos.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => VideoItemWidget(
                    video: listOfVideos[index],
                    index: index,
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
