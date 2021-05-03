import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedBarberImage extends StatelessWidget {
  final imageURL;
  const CachedBarberImage({this.imageURL});

  final blankPerson = 'https://firebasestorage.googleapis.com/v0/b/groomy-app.appspot.com/o/blank_person.png?alt=media&token=8aa4aaac-fc4d-4f7e-969e-fede531e46b2';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: imageURL == null
          ? CachedNetworkImage(
          imageUrl: blankPerson,
          fadeInDuration: Duration(milliseconds: 600),
          imageBuilder: (context, imageProvider) => Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
          placeholder: (context, url) => Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade100),
          ),
          errorWidget: (_, __, ___) =>
              Container(color: Colors.grey))

          : CachedNetworkImage(
          imageUrl: imageURL,
          fadeInDuration: Duration(milliseconds: 600),
          imageBuilder: (context, imageProvider) => Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
          placeholder: (context, url) => Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade100),
          ),
          errorWidget: (_, __, ___) =>
              Container(color: Colors.grey)),
    );
  }
}
