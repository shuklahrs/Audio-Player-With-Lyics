import 'package:audioplayer/bloc/Music/musicBloc.dart';
import 'package:audioplayer/bloc/Network/networkBloc.dart';
import 'package:audioplayer/pages/musicDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late MusicBloc musicBloc;
  late NetworkBloc networkBloc;
  @override
  void initState() {
    super.initState();
    musicBloc = BlocProvider.of<MusicBloc>(context);
    musicBloc.add(FetchMusic());
    networkBloc = BlocProvider.of<NetworkBloc>(context);
    networkBloc.add(ListenConnection());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF16A873),
        elevation: 0,
        title: Text("Collections",style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28, color: Colors.black87),),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          musicBloc.add(FetchMusic());
        },
        child: Stack(
          children: [
            BlocBuilder<MusicBloc, MusicState>(
              builder: (context, state) {
                if (state is MusicLoding) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (state is MusicLoded) {
                  print(state);
                  var usersList = state.responseUsers.message.body.trackList;
                  return ListView.builder(
                      itemCount: usersList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> DetailPage(usersList[index])));
                              },
                              leading: ClipOval(
                                child: Icon(Icons.music_note),
                              ),
                              title: Text(usersList[index].track.trackName),
                              subtitle: Text(usersList[index].track.albumName),
                            ),
                            Divider(),
                          ],
                        );
                      },
                  );
                } else if (state is MusicError) {}
                return Container();
              },
            ),
            Center(
              child: BlocBuilder<NetworkBloc, NetworkState>(
                builder: (context, state) {
                  if (state is ConnectionFailure)
                    return Text("No Internet Connection");
                  if (state is ConnectionSuccess)
                    return Text("You're Connected to Internet");
                  else
                    return Text("");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
