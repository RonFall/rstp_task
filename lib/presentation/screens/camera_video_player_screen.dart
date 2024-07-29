import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class CameraVideoPlayerScreen extends StatefulWidget {
  const CameraVideoPlayerScreen({
    required this.cameraUrl,
    required this.cameraIndex,
    super.key,
  });

  final String cameraUrl;
  final int cameraIndex;

  @override
  State<CameraVideoPlayerScreen> createState() =>
      _CameraVideoPlayerScreenState();
}

class _CameraVideoPlayerScreenState extends State<CameraVideoPlayerScreen> {
  Media? _media;
  Player? _player;
  VideoController? _controller;

  @override
  void initState() {
    super.initState();

    _initVideoController();
  }

  @override
  void didUpdateWidget(covariant CameraVideoPlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cameraUrl != oldWidget.cameraUrl) {
      _initVideoController();
    }
  }

  Future<void> _initVideoController() async {
    try {
      _player = null;
      _controller = null;
      _media = null;

      _player = Player();
      _controller = VideoController(_player!);
      _media = Media(widget.cameraUrl);
      await _player?.open(_media!);
    } on Object catch (e) {
      _player = null;
      _controller = null;
      _media = null;
      debugPrint('Player initialization error: $e');
    }
  }

  @override
  void dispose() {
    _player?.dispose();
    _player = null;
    _controller = null;
    _media = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera ${widget.cameraIndex}')),
      body: Builder(
        builder: (context) {
          final controller = _controller;
          if (controller == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ошибка инициализации плагина воспроизведения потокового '
                  'видео. Попробуйте перезапустить приложение',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
            );
          }

          return Center(
            child: Video(
              controller: controller,
              controls: (state) {
                // Убираем управление видео
                return const SizedBox.shrink();
              },
              height: MediaQuery.sizeOf(context).height / 3,
            ),
          );
        },
      ),
    );
  }
}
