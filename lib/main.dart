import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  runApp(const NetraEdgeApp());
}

class NetraEdgeApp extends StatelessWidget {
  const NetraEdgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetraEdge Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const NvrHomeScreen(),
    );
  }
}

class NvrHomeScreen extends StatefulWidget {
  const NvrHomeScreen({super.key});

  @override
  State<NvrHomeScreen> createState() => _NvrHomeScreenState();
}

class _NvrHomeScreenState extends State<NvrHomeScreen> {
  late VlcPlayerController _controller1;
  late VlcPlayerController _controller2;
  late VlcPlayerController _controller3;
  late VlcPlayerController _controller4;

  @override
  void initState() {
    super.initState();
    // Replace with your actual RTSP streams via Mediamtx / Cloudflare tunnel
    const String sampleRtsp = "rtsp://admin:password@your_tunnel_url/stream";
    
    _controller1 = VlcPlayerController.network(sampleRtsp, hwAcc: HwAcc.auto, autoPlay: true, options: VlcPlayerOptions());
    _controller2 = VlcPlayerController.network(sampleRtsp, hwAcc: HwAcc.auto, autoPlay: true, options: VlcPlayerOptions());
    _controller3 = VlcPlayerController.network(sampleRtsp, hwAcc: HwAcc.auto, autoPlay: true, options: VlcPlayerOptions());
    _controller4 = VlcPlayerController.network(sampleRtsp, hwAcc: HwAcc.auto, autoPlay: true, options: VlcPlayerOptions());
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'logo.png',
              height: 28,
              width: 28,
            ),
            const SizedBox(width: 8),
            const Text("NetraEdge Pro - 4CH NVR"),
          ],
        ),
        backgroundColor: Colors.black87,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 16 / 12,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: [
          _buildCameraCell("Cam 01 - Entrance", _controller1),
          _buildCameraCell("Cam 02 - Parking", _controller2),
          _buildCameraCell("Cam 03 - Server Room", _controller3),
          _buildCameraCell("Cam 04 - Backyard", _controller4),
        ],
      ),
    );
  }

  Widget _buildCameraCell(String title, VlcPlayerController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade800),
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.black54,
            child: Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ),
          Expanded(
            child: VlcPlayer(
              controller: controller,
              aspectRatio: 16 / 9,
              placeholder: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          ),
        ],
      ),
    );
  }
}
