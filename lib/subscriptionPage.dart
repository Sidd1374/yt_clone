import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;
import 'yt_widgets.dart';

class subsPageFrame extends StatelessWidget {
  const subsPageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> filterCategories = [
      'All',
      'Today',
      'Videos',
      'Shorts',
      'Live',
      'Podcasts',
      'Posts',
      'Unwatched',
    ];

    final List<Map<String, String>> channels = [
      {'name': 'Flutter', 'image': 'assets/images/pi1.png'},
      {'name': 'TechBro', 'image': 'assets/images/pi1.png'},
      {'name': 'CodeLab', 'image': 'assets/images/pi1.png'},
      {'name': 'DevTips', 'image': 'assets/images/pi1.png'},
      {'name': 'DartDev', 'image': 'assets/images/pi1.png'},
      {'name': 'FireShip', 'image': 'assets/images/pi1.png'},
      {'name': 'Google', 'image': 'assets/images/pi1.png'},
      {'name': 'Android', 'image': 'assets/images/pi1.png'},
    ];

    const List<ShortThumbnail> shortsHorizontal = [
      ShortThumbnail(
        title: "Flutter State Management",
        views: "89K views",
        imagePath: "assets/images/th1.jpg",
      ),
      ShortThumbnail(
        title: "Dart Fundamentals",
        views: "134K views",
        imagePath: "assets/images/th2.jpg",
      ),
      ShortThumbnail(
        title: "Firebase & Flutter",
        views: "267K views",
        imagePath: "assets/images/th1.jpg",
      ),
      ShortThumbnail(
        title: "Mobile Dev Tips",
        views: "156K views",
        imagePath: "assets/images/th2.jpg",
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildChannelAvatarsRow(context, channels),

            Divider(color: context.yt.divider, height: 1),

            // Filter category chips
            buildCategoryChips(context, filterCategories),

            // Shorts section
            buildShortsSection(context, shortsHorizontal),

            Divider(color: context.yt.divider, height: 1),

            // Video cards
            buildVideoCard(
              context,
              title: "What's New in Flutter 4.0",
              thumbnailPath: "assets/images/th1.jpg",
              views: "3.1M views",
              time: "1 day ago",
              profileImage: "assets/images/pi1.png",
              channelName: "Flutter",
            ),

            const CommunityPost(
              channelName: "Flutter",
              profileImage: "assets/images/pi1.png",
              timeAgo: "2 days ago",
              description:
                  "Flutter 4.0 is here! 🎉 Check out the new features "
                  "including improved performance, new widgets, and better tooling. "
                  "Let us know what you think in the comments!",
              postImage: "assets/images/th2.jpg",
            ),

            buildVideoCard(
              context,
              title: "Building Production Apps with Dart",
              thumbnailPath: "assets/images/th2.jpg",
              views: "1.5M views",
              time: "3 days ago",
              profileImage: "assets/images/pi1.png",
              channelName: "DartDev",
            ),
            buildVideoCard(
              context,
              title: "Firebase Tips and Tricks 2026",
              thumbnailPath: "assets/images/th1.jpg",
              views: "780K views",
              time: "1 week ago",
              profileImage: "assets/images/pi1.png",
              channelName: "FireShip",
            ),
          ],
        ),
      ),
    );
  }
}
