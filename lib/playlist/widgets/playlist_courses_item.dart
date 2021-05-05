import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/helpers/colors/colors.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PlaylistCourseItem extends StatelessWidget {
  String title;
  List<PlaylistItem> listOfCourses;
  PlaylistCourseItem({this.title, this.listOfCourses});

  final youtubeUrl = 'https://www.youtube.com/playlist?list=';

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

  Widget _titleOfSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            hoverColor: mGreyColor,
            splashColor: mGreyColor,
            focusColor: mGreyColor,
            highlightColor: mGreyColor,
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text('مشاهدة الجميع',
                  style: TextStyle(
                      color: mPrimaryBlackColor,
                      fontSize: 14,
                      fontFamily: "Arb")),
            ),
          ),
          Text(title,
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: "Arb")),
        ],
      ),
    );
  }

  Widget _contentOfSection(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    listOfCourses.shuffle();
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
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _launchURL(listOfCourses[index].id);
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
