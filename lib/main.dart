import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() => runApp(NetraEdgeApp());

class NetraEdgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NetraEdge Pro',
      theme: ThemeData.dark(),
      home: LiveGridScreen(),
    );
  }
}

class LiveGridScreen extends StatefulWidget {
  @override
  _LiveGridScreenState createState() => _LiveGridScreenState();
}

class _LiveGridScreenState extends State<LiveGridScreen> {
  late VlcPlayerController _ch1Controller;

  @override
  void initState() {
    super.initState();
    _ch1Controller = VlcPlayerController.network(
      'rtsp://your-tunnel-url.trycloudflare.com/ch1',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _ch1Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NetraEdge Pro - NVR Live"),
        backgroundColor: Colors.black87,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: [
          _buildCameraCard("CH 01 - Entrance", _ch1Controller),
          _buildCameraCard("CH 02 - Parking", null),
          _buildCameraCard("CH 03 - Warehouse", null),
          _phoneCameraCardPlaceholder("CH 04 - Office"),
        ],
      ),
    );
  }

  Widget _buildCameraCard(String title, VlcPlayerController? controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border.all(color: Colors.cyanAccent, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            color: Colors.black54,
            width: double.infinity,
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: controller != null
                ? VlcPlayer(
                    controller: controller,
                    aspectRatio: 16 / 9,
                    placeholder: Center(child: CircularProgressIndicator(color: Colors.cyan)),
                  )
                : Center(child: Text("No Signal", style: TextStyle(color: Colors.grey, fontSize: 12))),
          ),
        ],
      ),
    );
  }

  Widget _phoneCameraCardPlaceholder(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border.all(color: Colors.cyanAccent, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            color: Colors.black54,
            width: double.infinity,
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Center(child: Text("Connecting...", style: TextStyle(color: Colors.grey, fontSize: 12)))),
        ],
      ),
    );
  }
}

