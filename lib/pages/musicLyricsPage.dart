import 'package:audioplayer/Json/Music.dart';
import 'package:audioplayer/bloc/Song/songBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LyricsPage extends StatefulWidget {
  TrackList user;
  LyricsPage(this.user);

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  late SongBloc songBloc;

  @override
  void initState() {
    super.initState();
    songBloc = BlocProvider.of<SongBloc>(context);
    songBloc.add(FetchSong(songid: widget.user.track.trackId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        if (state is SongLoded) {
          var lyriclist = state.responcesong;
          Container(
            child: Text(lyriclist.lyricsBody),
          );
        }
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}
