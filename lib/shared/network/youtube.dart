import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:learn_in_arabic/shared/model/youtube_playlist_video_model.dart';
import 'package:learn_in_arabic/shared/model/youtube_video.dart';

class YoutubeRepository {
  final dio = Dio();
  final String channelId = 'UCiit2m7skf-rTBNVJEnHWoQ';
  // final String apiKey = 'AIzaSyAIUAVBvsSADB2B_8vh-CaNJOt7fuHQDgM';
  final String apiKey = 'AIzaSyA0fGpzYeDEpIWwRjgJVts9Xa-wTEdxYWs';
  // final String apiKey = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjE5ZmUyYTdiNjc5NTIzOTYwNmNhMGE3NTA3OTRhN2JkOWZkOTU5NjEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxMDAyNTQzODM5OTM1LWFrMzR1ajRxMW9lNDBybDc0cHY5bm9yNXEwYTRsMDdvLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiMTAwMjU0MzgzOTkzNS1vMW9qZWtqaDZ1OGIyY2M0NjZta25qNXRnZW45ZzgzbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjEwNDc2MjA4OTU2NDQ3NDkxNTE4MSIsImVtYWlsIjoieW91c3NlZmd1YmE2QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiWW91c3NlZiBBLlNhZWVkIC0g2YrZiNiz2YEg2KPYrdmF2K8g2LPYudmK2K8iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FPaDE0R2k5M19JNVE5NXRQbTMxSV82djV0RXB1WHFFcE5TcXZwa1FMYzBaLXc9czk2LWMiLCJnaXZlbl9uYW1lIjoiWW91c3NlZiBBLlNhZWVkIiwiZmFtaWx5X25hbWUiOiItINmK2YjYs9mBINij2K3ZhdivINiz2LnZitivIiwibG9jYWxlIjoiZW4iLCJpYXQiOjE2MjM4MzQ1ODcsImV4cCI6MTYyMzgzODE4N30.vpeD-VloE8qorLMOTDtFDAW7BUAnY9qqrpsrsdwbeGJZwXN4xochKhdB-wM8rDzzR8Zesso_9PGuAzY1mVasnrMKJffxkUeeNdvpHqnizFVEvZmYmIm80WdP_qD0PiZyJ63uJ8zIYQJnVD3ZxU-FIVZPby04Bjj1qJzLPwf__wLyvSC4IS17EpsMtd4HM7WlQ2kVGtSbXox8Xjh6o3NG7OtLrAN58COsD5_ujFtnULclorqqGEwNdxp9oS9ZbyLbdA5U-W3QmTuqgOTIlNniwUK_LDDINVo5XEVW9LFj47zmBy_YkmCX7v754caIL3656YuM2aQ8nzzKRinigl7XRw';
  final String playlistUrl = 'https://youtube.googleapis.com/youtube/v3/playlists';
  final String channelVideosUrl = 'https://youtube.googleapis.com/youtube/v3/search';
  final String playlistVideosUrl = 'https://youtube.googleapis.com/youtube/v3/playlistItems';


  Future<Youtube> getYoutubeChannelPlaylist() async {
    try {
      final response = await dio.get(playlistUrl,
          queryParameters: {
            'part': 'snippet',
            "channelId": channelId,
            'maxResults': 25,
            'key': apiKey,
            "Authorization": apiKey
          });

      final data = Youtube.fromJson(response.data);

      return data;
    } catch (e) {
      print('This is an e $e');
      return null;
    }
  }

  Future<YoutubePlaylistVideoModel> getPlaylistVideos(playlistId) async {
    try {
      final response = await dio.get(playlistVideosUrl,
          queryParameters: {
            'part': 'snippet',
            "playlistId": playlistId,
            'maxResults': 50,
            'key': apiKey,
            "Authorization": apiKey
          });

      final data = YoutubePlaylistVideoModel.fromJson(response.data);
      return data;
    } catch (e) {
      print('This is an e $e');
      return null;
    }
  }

  Future<YoutubeVideo> getChannelVideos(nextPageToken) async {
    try {
      final response = await dio.get(channelVideosUrl,
          queryParameters: {
            'part': 'snippet, id',
            'maxResults': 50,
            'channelId': channelId,
            'key': apiKey,
            "Authorization": apiKey,
            'order': 'viewCount',
            'pageToken': nextPageToken,
          });

      final data = YoutubeVideo.fromJson(response.data);
      print('This is a next page token ${data.nextPageToken}');
      return data;
    } catch (e) {
      print('This is an e $e');
      return null;
    }
  }


}
