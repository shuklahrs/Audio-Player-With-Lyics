import 'package:audioplayer/Repos/lyricsRepo.dart';
import 'package:audioplayer/Repos/musicRepo.dart';
import 'package:audioplayer/Repos/trackdetailsRepo.dart';
import 'package:audioplayer/bloc/Music/musicBloc.dart';
import 'package:audioplayer/bloc/Network/networkBloc.dart';
import 'package:audioplayer/bloc/Song/songBloc.dart';
import 'package:audioplayer/bloc/Track/trackBloc.dart';
import 'package:audioplayer/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MusicBloc(lyricsRepo: LyricsImpl(), songRepo: Songimpl()),
          child: HomePage(),
        ),
        BlocProvider(
          create: (context) => TrackBloc(trackdetailRepo: TrackdetailImpl(), songRepo: Songimpl()),
        ),
        BlocProvider(create: (context) => SongBloc(songRepo: Songimpl())),
        BlocProvider(create: (context) => NetworkBloc())
      ],
      child: MaterialApp(
        title: 'Music Player',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
