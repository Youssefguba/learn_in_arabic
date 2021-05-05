import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/helpers/colors/colors.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/model/youtube_playlist_video_model.dart';

// ignore: must_be_immutable
class VideoPlaylistItem extends StatelessWidget {
  String title;
  List<PlaylistVideoItem> listOfCourses;
  VideoPlaylistItem({this.title, this.listOfCourses});

  final youtubeUrl = 'https://www.youtube.com/watch?v=';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 5),
          _contentOfSection(context),
        ],
      ),
    );
  }

  Widget _contentOfSection(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // listOfCourses.shuffle();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height,
        width: double.infinity,
        child: GridView.builder(
          itemCount: listOfCourses.length,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 0.90,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _launchURL(listOfCourses[index].snippet.resourceId.videoId);
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: listOfCourses[index]
                                .snippet
                                .thumbnails
                                .medium
                                .url,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          listOfCourses[index].snippet.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Arb',
                              fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _launchURL(url) async => await canLaunch(youtubeUrl + url)
      ? await launch(youtubeUrl + url)
      : throw 'Could not launch ${youtubeUrl + url}';

}
