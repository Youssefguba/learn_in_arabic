import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:learn_in_arabic/shared/model/youtube_model.dart';

class YoutubeRepository {
  final dio = Dio();
  final String url = 'https://youtube.googleapis.com/youtube/v3/playlists';
  final String apiKey = 'AIzaSyAIUAVBvsSADB2B_8vh-CaNJOt7fuHQDgM';
  final String channelId = 'UCiit2m7skf-rTBNVJEnHWoQ';


  Future<Youtube> getYoutubeData() async {
    try {
      final response = await dio.get(url,
          queryParameters: {
            'part': 'snippet',
            "channelId": channelId,
            'maxResults': 25,
            'key': apiKey,
            "Authorization": apiKey
          });

      final data = Youtube.fromJson(response.data);
      print('This is an 0 ${data.items[1].id}');
      print('This is an 1 ${data.items[1].snippet.title}');
      print('This is an 2 ${data.items[2].snippet.title}');
      print('This is an 3 ${data.items[3].snippet.title}');
      print('This is an 4 ${data.items[4].snippet.title}');
      print('This is an 5 ${data.items[5].snippet.title}');
      print('This is an 6 ${data.items[6].snippet.title}');
      print('This is an 7 ${data.items[7].snippet.title}');

      return data;
    } catch (e) {
      print('This is an e $e');
      return null;
    }
  }
}
