import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:audioplayers/audioplayers.dart';

class MediaPlayerPage extends StatefulWidget {
  @override
  State<MediaPlayerPage> createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String src = ModalRoute.of(context)?.settings.arguments as String? ??
        'assets/videos/sample_video.mp4';
    _initializeVideo(src);
  }

  Future<void> _initializeVideo(String src) async {
    _videoController = VideoPlayerController.asset(src);
    await _videoController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: false,
      looping: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Media Player')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _chewieController == null
                ? Center(child: CircularProgressIndicator())
                : AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  ),
            Divider(),
            Text('Audio Player Demo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () =>
                      _audioPlayer.play(AssetSource('audio/sample_audio.mp3')),
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () => _audioPlayer.pause(),
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () => _audioPlayer.stop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
