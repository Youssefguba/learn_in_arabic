import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ThumbnailsShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              width: 180.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey.shade100),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.topRight,
                            child: Container(
                              width: width * 0.15,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeVideosShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              width: width,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey.shade100),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

