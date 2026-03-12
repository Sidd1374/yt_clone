import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;
import 'yt_widgets.dart';
import 'containerFrame.dart';

class homePageFrame extends StatelessWidget {
  const homePageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> categories = [
      'All',
      'Technology',
      'APIs',
      'Music',
      'Podcasts',
      'AI',
      'Gaming',
      'Movies',
      'Live',
    ];

    const List<ShortThumbnail> shortsGrid = [
      ShortThumbnail(
        title: "Flutter UI Tips",
        views: "245K views",
        imagePath: "assets/images/th1.jpg",
      ),
      ShortThumbnail(
        title: "Dart Programming",
        views: "180K views",
        imagePath: "assets/images/th2.jpg",
      ),
    ];

    const List<ShortThumbnail> shortsHorizontal = [
      ShortThumbnail(
        title: "Quick Flutter Tip #1",
        views: "125K views",
        imagePath: "assets/images/th1.jpg",
      ),
      ShortThumbnail(
        title: "Quick Flutter Tip #2",
        views: "98K views",
        imagePath: "assets/images/th2.jpg",
      ),
      ShortThumbnail(
        title: "Quick Flutter Tip #3",
        views: "156K views",
        imagePath: "assets/images/th1.jpg",
      ),
      ShortThumbnail(
        title: "Quick Flutter Tip #4",
        views: "203K views",
        imagePath: "assets/images/th2.jpg",
      ),
    ];

    return Scaffold(
      body: Builder(
        builder: (scaffoldContext) {
          Widget exploreIcon = Container(
            margin: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: context.yt.chipBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(
                Icons.explore_outlined,
                color: context.yt.textPrimary,
                size: 20,
              ),
              onPressed: () {
                rootScaffoldKey.currentState?.openDrawer();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 32),
            ),
          );

          return Column(
            children: [
              buildCategoryChips(context, categories, leading: exploreIcon),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildShortsGridSection(context, shortsGrid),
                      buildVideoCard(
                        scaffoldContext,
                        title: "Flutter Tutorial for Beginners",
                        thumbnailPath: "assets/images/th1.jpg",
                        views: "1.2M views",
                        time: "2 days ago",
                        profileImage: "assets/images/pi1.png",
                        channelName: "Flutter",
                      ),
                      buildVideoCard(
                        scaffoldContext,
                        title: "Building a YouTube Clone in Flutter",
                        thumbnailPath: "assets/images/th2.jpg",
                        views: "890K views",
                        time: "1 week ago",
                        profileImage: "assets/images/pi1.png",
                        channelName: "TechBro",
                      ),

                      buildShortsSection(scaffoldContext, shortsHorizontal),
                      const CommunityPost(
                        channelName: "Prime Video Sport",
                        profileImage: "assets/images/pi1.png",
                        timeAgo: "6 hours ago",
                        description:
                            "Starting the day with back to back NBA action 🏀 "
                            "Catch the best games and highlights live only on Prime Video. "
                            "Coverage begins early so don't miss it!",
                        postImage: "assets/images/th1.jpg",
                      ),

                      buildVideoCard(
                        scaffoldContext,
                        title: "Dart Programming Complete Course",
                        thumbnailPath: "assets/images/th1.jpg",
                        views: "2.3M views",
                        time: "3 days ago",
                        profileImage: "assets/images/pi1.png",
                        channelName: "CodeLab",
                      ),
                      buildVideoCard(
                        scaffoldContext,
                        title: "Top 10 Flutter Packages in 2026",
                        thumbnailPath: "assets/images/th2.jpg",
                        views: "450K views",
                        time: "5 days ago",
                        profileImage: "assets/images/pi1.png",
                        channelName: "DevTips",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
