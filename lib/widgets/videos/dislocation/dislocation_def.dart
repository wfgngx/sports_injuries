import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DislocationDefVid extends StatefulWidget {
  const DislocationDefVid({Key? key,required this.vidUrl}) : super(key: key);
  final vidUrl;

  @override
  State<DislocationDefVid> createState() => _DislocationDefVidState();
}

class _DislocationDefVidState extends State<DislocationDefVid> {
  late VideoPlayerController _controllerDefVid;
  late Future<void> _initializeVideoPlayerFutureDefVid;
  @override
  void initState() {
    super.initState();
    _controllerDefVid = VideoPlayerController.asset(
        widget.vidUrl);
    _initializeVideoPlayerFutureDefVid = _controllerDefVid.initialize();
  }

  @override
  void dispose() {
    _controllerDefVid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFutureDefVid,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controllerDefVid.value.aspectRatio,
                child: VideoPlayer(_controllerDefVid),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        IconButton(
          style: const ButtonStyle(iconSize: MaterialStatePropertyAll(32)),
          color: Colors.blue,
            onPressed: () {
              setState(() {
                if (_controllerDefVid.value.isPlaying) {
                  _controllerDefVid.pause();
                } else {
                  _controllerDefVid.play();
                }
              });
            },
            icon: Icon(
              
              _controllerDefVid.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ))
      ],
    );
  }
}
