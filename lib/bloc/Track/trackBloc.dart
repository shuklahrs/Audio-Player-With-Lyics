import 'dart:async';
import 'package:audioplayer/Json/Song.dart';
import 'package:audioplayer/Json/Track.dart';
import 'package:audioplayer/Repos/musicRepo.dart';
import 'package:audioplayer/Repos/trackdetailsRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'trackEvent.dart';
part 'trackState.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  TrackdetailRepo trackdetailRepo;
  SongRepo songRepo;

  TrackBloc({required this.trackdetailRepo, required this.songRepo}) : super(TrackInitial());

  @override
  Stream<TrackState> mapEventToState(
      TrackEvent event,
      ) async* {
    if (event is Fetchtrack) {
      yield Trackloding();
      try {
        final Trackdetail responcetrack =
        await trackdetailRepo.gettrackdetail(event.trackid);
        final Lyrics responcesong = await songRepo.getsong(event.trackid);
        yield TrackLoded(responcesong: responcesong, responcetrack: responcetrack);
      } catch (e) {}
    }
  }
}
