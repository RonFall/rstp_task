import 'package:flutter/material.dart';
import 'package:rtsp_task/presentation/screens/camera_video_player_screen.dart';

class RtspApp extends StatefulWidget {
  const RtspApp({super.key});

  @override
  State<RtspApp> createState() => _RtspAppState();
}

class _RtspAppState extends State<RtspApp> {
  late final List<String> _camUrls;

  @override
  void initState() {
    super.initState();
    _camUrls = <String>[
      'rtsp://178.141.80.235:55554/Esd93HFV_s/',
      'rtsp://178.141.80.235:55555/md5IffuT_s/',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter RTSP',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter RTSP')),
        body: Center(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _camUrls.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return CameraVideoPlayerScreen(
                          cameraUrl: _camUrls[index],
                          cameraIndex: index + 1,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'CAM ${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

