import 'package:flutter/material.dart';
import 'package:yt_clone/yt_widgets.dart' as wid;

class ExploreBento extends StatefulWidget {
  const ExploreBento({super.key});

  @override
  State<ExploreBento> createState() => _ExploreBentoState();
}

class _ExploreBentoState extends State<ExploreBento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: wid.buildBentoExplore(context));
  }
}
