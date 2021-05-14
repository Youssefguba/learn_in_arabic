import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/helpers/colors/colors.dart';
import 'package:learn_in_arabic/playlist/playlist.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/model/youtube_playlist_video_model.dart';

class VideosSection extends StatelessWidget {
  String title;
  List<PlaylistVideoItem> listOfCourses;
  Function onTap;
  VideosSection({this.title, this.listOfCourses, this.onTap});

  final youtubeUrl = 'https://www.youtube.com/watch?v=';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 5),
            _titleOfSection(context),
            SizedBox(height: 8),
            _contentOfSection(context),
          ],
        ),
      ),
    );
  }

  Widget _titleOfSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Arb")),

          InkWell(
            onTap: onTap,
            hoverColor: mGreyColor,
            splashColor: mGreyColor,
            focusColor: mGreyColor,
            highlightColor: mGreyColor,
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text('مشاهدة الجميع',
                  style: TextStyle(
                      color: mPrimaryBlackColor.withOpacity(0.5),
                      fontSize: 14,
                      fontFamily: "Arb")),
            ),
          ),

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
        height: height * 0.18,
        child: ListView.builder(
          itemCount: listOfCourses.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _launchURL(listOfCourses[index].snippet.resourceId.videoId),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: listOfCourses[index].snippet.thumbnails.high.url,
                            height: 100,
                            width: 180,
                            fit: BoxFit.cover,
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
