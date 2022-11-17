import 'package:audioplayer/Json/Music.dart';
import 'package:audioplayer/bloc/Track/trackBloc.dart';
import 'package:audioplayer/pages/musicLyricsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  TrackList trackList;
  DetailPage(this.trackList);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TrackBloc trackBloc;
  @override
  void initState() {
    super.initState();
    trackBloc = BlocProvider.of<TrackBloc>(context);
    trackBloc.add(Fetchtrack(trackid: (widget.trackList.track.trackId)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackBloc, TrackState>(
      builder: (context, state) {
        if (state is Trackloding) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TrackLoded) {
          var songlist = state.responcesong;
          return Container(
            child: LyricsPage(widget.trackList),
          );
        }
        return Container();
      }
    );
  }
}
