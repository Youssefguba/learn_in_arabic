import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/home/home.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';

import '../playlist.dart';

class PlaylistScreen extends StatefulWidget {
  final List<PlaylistItem> listOfCourses;
  final title;
  const PlaylistScreen({Key key, this.listOfCourses,  this.title}) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mSecondaryColor,
        title: Text(widget.title, style: TextStyle(color: Colors.black, fontFamily: 'Arb'),),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: BlocBuilder<ProgrammingContentBloc, ProgrammingContentState>(
            builder: (context, state) {
              if(state is LoadingToGetProgrammingContent) {
                return Flexible(flex:1, child: ThumbnailsShimmerWidget());
              }
              if(state is GetProgrammingContentStateDone){
                return PlaylistCourseItem(title: 'تعلموا البرمجة', listOfCourses: widget.listOfCourses);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
