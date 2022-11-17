import 'dart:convert' as convert;

import 'package:audioplayer/Json/Music.dart';
import 'package:http/http.dart' as http;

abstract class LyricsRepo {
  Future<Music> gettrack();
}

class LyricsImpl extends LyricsRepo {
  @override
  Future<Music> gettrack() async {
    print("CALLING API");
    final url =
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=fc5b5b9cce3700a564dfc55bf3834c76';
    print(url);
    var response = await http.get(url);
    print(response);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return Music.fromJson(jsonResponse);
    } else {
      throw new Exception('error getting quotes');
    }
  }
}
