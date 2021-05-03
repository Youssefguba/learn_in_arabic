import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/home/widgets/courses_section.dart';
import 'package:learn_in_arabic/masaqat/blocs/masaqat/masaqat_bloc.dart';
import 'package:learn_in_arabic/playlist/playlist.dart';

import '../masaqat.dart';

class MasaqatTab extends StatefulWidget {
  @override
  _MasaqatTabState createState() => _MasaqatTabState();
}

class _MasaqatTabState extends State<MasaqatTab> {
  double _screenWidth, _screenHeight;

  @override
  void initState() {
    super.initState();

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
          width: _screenWidth,
          child: Column(
            children: [
              BlocBuilder<MasaqatBloc, MasaqatState>(
                builder: (context, state) {
                  if (state is LoadingToGetMasaqatContent) {
                    return Flexible(flex: 1, child: ThumbnailsShimmerWidget());
                  }
                  if (state is GetListOfMasaqatStateDone) {
                    final snippet = state.listOfPlaylist;
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

            ],
          ),
        ),
      ),
    );
  }
}
