import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/home/widgets/courses_section.dart';
import 'package:learn_in_arabic/playlist/playlist.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  double _screenWidth, _screenHeight;

  @override
  void initState() {
    super.initState();
    context.read<MediaContentBloc>().add(GetMediaPlaylistEvent());
    context.read<BusinessContentBloc>().add(GetBusinessPlaylistEvent());
    context.read<ProgrammingContentBloc>().add(GetProgrammingPlaylistEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
  }

  final youtubeUrl = 'https://www.youtube.com/watch?v=';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          width: _screenWidth,
          child: BlocBuilder<ProgrammingContentBloc, ProgrammingContentState>(
            builder: (context, state) {
              if (state is LoadingToGetProgrammingContent) {
                return Flexible(flex: 1, child: ThumbnailsShimmerWidget());
              }
              if (state is GetProgrammingContentStateDone) {
                final listOfCourses = state.listOfVideos;
                listOfCourses.shuffle();
                return ListView.builder(
                  itemCount: listOfCourses.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async => _launchURL(listOfCourses[index].id.videoId),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: listOfCourses[index].snippet.thumbnails.medium.url,
                            height: 210,
                            width: _screenWidth,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
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

  void _launchURL(url) async => await canLaunch(youtubeUrl + url)
      ? await launch(youtubeUrl + url)
      : throw 'Could not launch ${youtubeUrl + url}';
}
