// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
//
// class CameraFullScreenPage extends StatefulWidget {
//   final String rtspUrl;
//
//   const CameraFullScreenPage({super.key, required this.rtspUrl});
//
//   @override
//   State<CameraFullScreenPage> createState() => _CameraFullScreenPageState();
// }
//
// class _CameraFullScreenPageState extends State<CameraFullScreenPage> {
//   late VlcPlayerController _vlcController;
//
//   @override
//   void initState() {
//     super.initState();
//     _vlcController = VlcPlayerController.network(
//       widget.rtspUrl,
//       hwAcc: HwAcc.auto,
//       autoPlay: true,
//       options: VlcPlayerOptions(),
//     );
//   }
//
//   @override
//   void dispose() {
//     _vlcController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text("Live Stream", style: TextStyle(color: Colors.white)),
//       ),
//       body: Center(
//         child: VlcPlayer(
//           controller: _vlcController,
//           aspectRatio: 16 / 9,
//           placeholder: const Center(child: CircularProgressIndicator()),
//         ),
//       ),
//     );
//   }
// }
