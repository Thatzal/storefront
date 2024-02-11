// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
//
// import 'package:video_player/video_player.dart';
//
//
// class MovieTheaterBody extends StatefulWidget {
//   final String encodedBytes;
//
//   const MovieTheaterBody({ Key? key, required this.encodedBytes}) : super(key: key);
//
//   @override
//   _MovieTheaterBodyState createState() => _MovieTheaterBodyState();
// }
//
// class _MovieTheaterBodyState extends State<MovieTheaterBody> {
//   late Future<VideoPlayerController> _futureController;
//   late VideoPlayerController _controller;
//
//
//
//   @override
//   void initState() {
//     _futureController = createVideoPlayer();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//   Future<String> _createFileFromString(encodedStr) async {
//     Uint8List bytes = base64.decode(encodedStr);
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     String fullPath = '$dir/abc.mp4';
//     print("local file full path ${fullPath}");
//     File file = File(fullPath);
//     await file.writeAsBytes(bytes);
//     print(file.path);
//     final result = await ImageGallerySaver.saveImage(bytes);
//     print(result);
//     return file.path;
//   }
//   Future<VideoPlayerController> createVideoPlayer() async {
//     final String file = await _createFileFromString(widget.encodedBytes);
//     final VideoPlayerController controller = VideoPlayerController.file(File(file.toString()));
//     await controller.initialize();
//     await controller.setLooping(true);
//     return controller;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FutureBuilder(
//         future: _futureController,
//         builder: (context, snapshot) {
//           //UST: 05/2021 - MovieTheaterBody - id:11 - 2pts - Criação
//           if (snapshot.connectionState == ConnectionState.done) {
//             _controller = snapshot.data as VideoPlayerController;
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 FloatingActionButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_controller.value.isPlaying) {
//                         _controller.pause();
//                       } else {
//                         // If the video is paused, play it.
//                         _controller.play();
//                       }
//                     });
//                   },
//                   backgroundColor: Colors.green[700],
//                   child: Icon(
//                     _controller.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                   ),
//                 )
//               ],
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }