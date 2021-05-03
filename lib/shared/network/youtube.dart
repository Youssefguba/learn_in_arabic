import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:learn_in_arabic/shared/model/youtube_playlist_video_model.dart';

class YoutubeRepository {
  final dio = Dio();
  final String playlistUrl = 'https://youtube.googleapis.com/youtube/v3/playlists';
  final String apiKey = 'AIzaSyAIUAVBvsSADB2B_8vh-CaNJOt7fuHQDgM';
  final String channelId = 'UCiit2m7skf-rTBNVJEnHWoQ';

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
            "playlistId": 'PLR1jYXePZaNQUOHWtQn9aeyZ8F4flCn30',
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
}
