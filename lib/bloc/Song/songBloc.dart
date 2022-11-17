import 'dart:async';

import 'package:audioplayer/Json/Song.dart';
import 'package:audioplayer/Repos/musicRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'songEvent.dart';
part 'songState.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  SongRepo songRepo;

  SongBloc({required this.songRepo}) : super(SongInitial());

  @override
  Stream<SongState> mapEventToState(
      SongEvent event,
      ) async* {
    if (event is FetchSong) {
      yield SongLoding();
      try {
        final Lyrics responcesong = await songRepo.getsong(event.songid);
        yield SongLoded(responcesong: responcesong);
      } catch (e) {
        print(e);
      }
    }
  }
}
