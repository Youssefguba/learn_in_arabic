import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/helpers/widgets/video_item_widget.dart';

import '../home.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  double _screenWidth, _screenHeight;
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

  @override
  Widget build(BuildContext context) {
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
                    itemBuilder: (context, index) =>
                        VideoItemWidget(video: listOfVideos[index], index: index));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
