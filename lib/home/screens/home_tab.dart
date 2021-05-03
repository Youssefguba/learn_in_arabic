import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/home/widgets/courses_section.dart';
import 'package:learn_in_arabic/playlist/playlist.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          height: _screenHeight,
          child: Column(
            children: [
              // Programming Content
              BlocBuilder<ProgrammingContentBloc, ProgrammingContentState>(
                builder: (context, state) {
                  if (state is LoadingToGetProgrammingContent) {
                    return Flexible(flex: 1, child: ThumbnailsShimmerWidget());
                  }
                  if (state is GetProgrammingContentStateDone) {
                    final snippet = state.listOfProgrammingPlaylist;
                    final title = 'تعلموا البرمجة';
                    return CoursesSection(
                      title: title,
                      listOfCourses: snippet,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PlaylistScreen(
                                title: title, listOfCourses: snippet)));
                      },
                    );
                  }
                  return Container();
                },
              ),

              // Business Content
              BlocBuilder<BusinessContentBloc, BusinessContentState>(
                builder: (context, state) {
                  if (state is LoadingToGetBusinessContent) {
                    return Flexible(flex: 1, child: ThumbnailsShimmerWidget());
                  }
                  if (state is GetBusinessContentStateDone) {
                    final item = state.listOfBusinessPlaylist;
                    final title = 'ريادة الأعمال';
                    return CoursesSection(
                      title: title,
                      listOfCourses: item,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PlaylistScreen(
                                title: title, listOfCourses: item)));
                      },
                    );
                  }
                  return Container();
                },
              ),

              // Media Content
              BlocBuilder<MediaContentBloc, MediaContentState>(
                builder: (context, state) {
                  if (state is LoadingToGetMediaContent) {
                    return Flexible(flex: 1, child: ThumbnailsShimmerWidget());
                  }
                  if (state is GetMediaContentStateDone) {
                    final snippet = state.listOfMediaPlaylist;
                    final title = 'التصوير & صناعة الفيديو';
                    return CoursesSection(
                      title: title,
                      listOfCourses: snippet,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PlaylistScreen(
                                title: title, listOfCourses: snippet)));
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
