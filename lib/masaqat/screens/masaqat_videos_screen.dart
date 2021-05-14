
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/masaqat/widgets/video_item.dart';

import '../../helpers/helpers.dart';
import '../../playlist/playlist.dart';
import '../../shared/model/youtube_model.dart';
import '../../shared/model/youtube_playlist_video_model.dart';
import '../blocs/masaqat/masaqat_bloc.dart';

class MasaqatVideosScreen extends StatefulWidget {
  final List<PlaylistVideoItem> listOfVideos;
  final title;
  const MasaqatVideosScreen({Key key, this.listOfVideos,  this.title}) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<MasaqatVideosScreen> {
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
          child: BlocBuilder<MasaqatBloc, MasaqatState>(
            builder: (context, state) {
              if(state is LoadingToGetMasaqatContent) {
                return Flexible(flex:1, child: ThumbnailsShimmerWidget());
              }
              if(state is GetListOfMasaqatStateDone){

                return VideoPlaylistItem(title: 'تعلموا البرمجة', listOfCourses: widget.listOfVideos);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
