import 'package:audioplayer/Json/Track.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class TrackdetailRepo {
  Future<Trackdetail> gettrackdetail(int trackid);
}

class TrackdetailImpl extends TrackdetailRepo {
  @override
  Future<Trackdetail> gettrackdetail(int trackid) async {
    print("Calling Api");
    final url =
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackid&apikey=fc5b5b9cce3700a564dfc55bf3834c76";
    print(url);
    var responce = await http.get(url);
    print(responce);
    if (responce.statusCode == 200) {
      var jsonresponce = convert.jsonDecode(responce.body);
      return Trackdetail.fromJson(jsonresponce);
    } else {
      throw new Exception('error getting quotes');
    }
  }
}
