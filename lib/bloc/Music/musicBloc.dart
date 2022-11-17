import 'dart:async';

import 'package:audioplayer/Json/Music.dart';
import 'package:audioplayer/Repos/lyricsRepo.dart';
import 'package:audioplayer/Repos/musicRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'musicEvent.dart';
part 'musicState.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
LyricsRepo lyricsRepo;
SongRepo songRepo;
MusicBloc({required this.lyricsRepo, required this.songRepo}) : super(MusicInitial());

@override
Stream<MusicState> mapEventToState(
    MusicEvent event,
    ) async* {
  if (event is FetchMusic) {
    yield MusicLoding();
    try {
      final Music responseUsers = await lyricsRepo.gettrack();
      yield MusicLoded(responseUsers: responseUsers);
    } catch (e) {
      print(e);
    }
  }
}
}