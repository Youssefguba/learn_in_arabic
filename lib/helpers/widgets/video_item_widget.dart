import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/shared/model/youtube_video.dart';
import 'package:learn_in_arabic/wishlist/wishlist.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItemWidget extends StatefulWidget {
  final VideoItem video;
  final index;
  bool isFavourite;
  VideoItemWidget({Key key, this.video, this.index, this.isFavourite = false}) : super(key: key);

  @override
  _VideoItemWidgetState createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget> {
  double _screenWidth, _screenHeight;
  ScrollController _videosScrollController = ScrollController();
  final youtubeUrl = 'https://www.youtube.com/watch?v=';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          onTap: () async => _launchURL(widget.video.id.videoId),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: widget.video.snippet.thumbnails.high.url,
                height: 210,
                width: _screenWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.isFavourite
                ? context
                    .read<WishListBloc>()
                    .add(RemoveItemFromWishListEvent(widget.index))
                : context
                    .read<WishListBloc>()
                    .add(AddItemToWishListEvent(widget.video));

            setState(() {
              widget.isFavourite = !widget.isFavourite;
            });
          },
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: mPrimaryBlackColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.isFavourite
                        ? Icon(Icons.favorite_rounded, color: Colors.white)
                        : Icon(Icons.favorite_border_rounded,
                            color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'أضف إلى المفضلة',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Arb', fontSize: 14),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  void _launchURL(url) async => await canLaunch(youtubeUrl + url)
      ? await launch(youtubeUrl + url)
      : throw 'Could not launch ${youtubeUrl + url}';
}
