// To parse this JSON data, do
//
//     final youtubePlaylistModel = youtubePlaylistModelFromJson(jsonString);

import 'dart:convert';

YoutubePlaylistVideoModel youtubePlaylistModelFromJson(String str) => YoutubePlaylistVideoModel.fromJson(json.decode(str));

String youtubePlaylistModelToJson(YoutubePlaylistVideoModel data) => json.encode(data.toJson());

class YoutubePlaylistVideoModel {
  YoutubePlaylistVideoModel({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.items,
    this.pageInfo,
  });

  String kind;
  String etag;
  String nextPageToken;
  List<PlaylistVideoItem> items;
  PageInfo pageInfo;

  factory YoutubePlaylistVideoModel.fromJson(Map<String, dynamic> json) => YoutubePlaylistVideoModel(
    kind: json["kind"],
    etag: json["etag"],
    nextPageToken: json["nextPageToken"],
    items: List<PlaylistVideoItem>.from(json["items"].map((x) => PlaylistVideoItem.fromJson(x))),
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "nextPageToken": nextPageToken,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "pageInfo": pageInfo.toJson(),
  };
}

class PlaylistVideoItem {
  PlaylistVideoItem({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
  });

  String kind;
  String etag;
  String id;
  Snippet snippet;

  factory PlaylistVideoItem.fromJson(Map<String, dynamic> json) => PlaylistVideoItem(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"],
    snippet: Snippet.fromJson(json["snippet"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id,
    "snippet": snippet.toJson(),
  };
}

class Snippet {
  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.playlistId,
    this.position,
    this.resourceId,
    this.videoOwnerChannelTitle,
    this.videoOwnerChannelId,
  });

  DateTime publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  String playlistId;
  int position;
  ResourceId resourceId;
  String videoOwnerChannelTitle;
  String videoOwnerChannelId;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    publishedAt: DateTime.parse(json["publishedAt"]),
    channelId: json["channelId"],
    title: json["title"],
    description: json["description"],
    thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    channelTitle: json["channelTitle"],
    playlistId: json["playlistId"],
    position: json["position"],
    resourceId: ResourceId.fromJson(json["resourceId"]),
    videoOwnerChannelTitle: json["videoOwnerChannelTitle"],
    videoOwnerChannelId: json["videoOwnerChannelId"],
  );

  Map<String, dynamic> toJson() => {
    "publishedAt": publishedAt.toIso8601String(),
    "channelId": channelId,
    "title": title,
    "description": description,
    "thumbnails": thumbnails.toJson(),
    "channelTitle": channelTitle,
    "playlistId": playlistId,
    "position": position,
    "resourceId": resourceId.toJson(),
    "videoOwnerChannelTitle": videoOwnerChannelTitle,
    "videoOwnerChannelId": videoOwnerChannelId,
  };
}

class ResourceId {
  ResourceId({
    this.kind,
    this.videoId,
  });

  String kind;
  String videoId;

  factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
    kind: json["kind"],
    videoId: json["videoId"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "videoId": videoId,
  };
}

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
    this.standard,
  });

  Default thumbnailsDefault;
  Default medium;
  Default high;
  Default standard;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json["default"]),
    medium: Default.fromJson(json["medium"]),
    high: Default.fromJson(json["high"]),
    standard: Default.fromJson(json["standard"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault.toJson(),
    "medium": medium.toJson(),
    "high": high.toJson(),
    "standard": standard.toJson(),
  };
}

class Default {
  Default({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

class PageInfo {
  PageInfo({
    this.totalResults,
    this.resultsPerPage,
  });

  int totalResults;
  int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalResults: json["totalResults"],
    resultsPerPage: json["resultsPerPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults,
    "resultsPerPage": resultsPerPage,
  };
}
