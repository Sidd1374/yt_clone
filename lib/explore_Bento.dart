import 'package:flutter/material.dart';
import 'package:yt_clone/yt_widgets.dart' as wid;

class ExploreBento extends StatefulWidget {
  const ExploreBento({super.key});

  @override
  State<ExploreBento> createState() => _ExploreBentoState();
}

class _ExploreBentoState extends State<ExploreBento> {
  final List<String> _bentoImages = const [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/videos/Final_Reel_01.mp4',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/videos/Final_Reel_01.mp4',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
    'assets/images/img7.jpg',
    'assets/images/img8.jpg',
    'assets/images/img9.jpg',
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
    'assets/images/img7.jpg',
    'assets/images/img8.jpg',
    'assets/images/img9.jpg',
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
    'assets/images/img7.jpg',
    'assets/images/img8.jpg',
    'assets/images/img9.jpg',
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
    'assets/images/img7.jpg',
    'assets/images/img8.jpg',
    // 'assets/images/img9.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wid.buildBentoExplore(context, imagePaths: _bentoImages),
    );
  }
}
