import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme_yt.dart' as th;
import 'videoPlayerPage.dart';

// builds a single chip
Widget buildChip(BuildContext context, String text, {bool selected = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: selected ? context.yt.chipSelectedBg : context.yt.chipBg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: selected
              ? context.yt.chipSelectedText
              : context.yt.textPrimary,
          fontSize: 14,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    ),
  );
}

// builds horizontal scrollable category chips
Widget buildCategoryChips(
  BuildContext context,
  List<String> categories, {
  Widget? leading,
}) {
  return SizedBox(
    height: 50,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length + (leading != null ? 1 : 0),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        if (leading != null && index == 0) return leading;
        final catIndex = leading != null ? index - 1 : index;
        return buildChip(
          context,
          categories[catIndex],
          selected: catIndex == 0,
        );
      },
    ),
  );
}

// builds a video card with thumbnail and info
Widget buildVideoCard(
  BuildContext context, {
  required String title,
  required String thumbnailPath,
  required String views,
  required String time,
  required String profileImage,
  String channelName = "Channel Name",
  String? videoUrl,
  String? videoAsset,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(
            title: title,
            channelName: channelName,
            views: views,
            time: time,
            profileImage: profileImage,
            videoUrl: videoUrl,
            videoAsset: videoAsset,
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              thumbnailPath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(profileImage),
                radius: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: context.yt.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$channelName • $views • $time",
                      style: TextStyle(
                        color: context.yt.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, color: context.yt.textSecondary, size: 20),
            ],
          ),
        ],
      ),
    ),
  );
}

// builds the shorts section with horizontal thumbnails
Widget buildShortsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/shorts24x_color.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              "Shorts",
              style: TextStyle(
                color: context.yt.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.chevron_right, color: context.yt.textSecondary),
          ],
        ),
      ),

      SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: 4,
          itemBuilder: (context, index) {
            return _buildShortThumbnail(
              context: context,
              title: "Short video title #${index + 1}",
              views: "${(index + 1) * 100}K views",
              imagePath: index.isEven
                  ? "assets/images/th1.jpg"
                  : "assets/images/th2.jpg",
            );
          },
        ),
      ),

      const SizedBox(height: 8),
    ],
  );
}

// builds a single short thumbnail card
Widget _buildShortThumbnail({
  required BuildContext context,
  required String title,
  required String views,
  required String imagePath,
}) {
  return Container(
    width: 160,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: context.yt.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    views,
                    style: TextStyle(
                      color: context.yt.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// builds a channel avatar with name
Widget buildChannelAvatar(
  BuildContext context, {
  required String name,
  required String imagePath,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(backgroundImage: AssetImage(imagePath), radius: 24),
        const SizedBox(height: 4),
        SizedBox(
          width: 64,
          child: Text(
            name,
            style: TextStyle(color: context.yt.textSecondary, fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// builds horizontal scrollable channel avatars row
Widget buildChannelAvatarsRow(
  BuildContext context,
  List<Map<String, String>> channels,
) {
  return SizedBox(
    height: 90,
    child: Stack(
      children: [
        Positioned.fill(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 2,
              right: 60,
              top: 8,
              bottom: 8,
            ),
            itemCount: channels.length,
            itemBuilder: (context, index) {
              return buildChannelAvatar(
                context,
                name: channels[index]['name']!,
                imagePath: channels[index]['image']!,
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: 48,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.yt.surface,
              ),
              child: Center(
                child: Text(
                  "All",
                  style: TextStyle(
                    color: context.yt.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
