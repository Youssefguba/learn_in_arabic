import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/masaqat/blocs/masaqat/masaqat_bloc.dart';
import 'package:learn_in_arabic/masaqat/screens/masaqat_videos_screen.dart';

import '../blocs/masaqat/masaqat_bloc.dart';
import '../widgets/videos_section.dart';

class MasaqatTab extends StatefulWidget {
  @override
  _MasaqatTabState createState() => _MasaqatTabState();
}

class _MasaqatTabState extends State<MasaqatTab> {
  double _screenWidth, _screenHeight;

  @override
  void initState() {
    super.initState();
    context.read<MasaqatBloc>().add(GetListOfMasaqatEvent());
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
        physics: BouncingScrollPhysics(),
        child: Container(
          width: _screenWidth,
          child: BlocBuilder<MasaqatBloc, MasaqatState>(
            builder: (context, state) {
              if (state is LoadingToGetMasaqatContent) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) => ThumbnailsShimmerWidget());
              }
              if (state is GetListOfMasaqatStateDone) {
                final listOfPlaylist = state.listOfPlaylist;
                final listOfVideos = state.listOfVideos;
                final title = '';
                return ListView.builder(
                  itemCount: listOfPlaylist.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return VideosSection(
                      title: listOfPlaylist[index].snippet.title,
                      listOfCourses: listOfVideos[index].items,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => MasaqatVideosScreen(
                                title: title,
                                listOfVideos: listOfVideos[index].items)));
                      },
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
