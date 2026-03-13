import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme_yt.dart' as th;
import 'videoPlayerPage.dart';
import 'shortsPage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// data model for shorts thumbnail
class ShortThumbnail {
  final String title;
  final String views;
  final String imagePath;

  const ShortThumbnail({
    required this.title,
    required this.views,
    required this.imagePath,
  });
}

// Simple tile widget for demonstration
class _BentoTile extends StatelessWidget {
  final int index;
  const _BentoTile({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[(index % 9 + 1) * 100],
      child: Center(child: Text('Tile $index')),
    );
  }
}

// builds a single chip
Widget buildChip(BuildContext context, String text, {bool selected = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? context.yt.chipSelectedBg : context.yt.chipBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: th.YtText.label.copyWith(
                color: selected
                    ? context.yt.chipSelectedText
                    : context.yt.textPrimary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
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
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                thumbnailPath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
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
                      style: th.YtText.videoTitle.copyWith(
                        color: context.yt.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$channelName • $views • $time",
                      style: th.YtText.videoMeta.copyWith(
                        color: context.yt.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => showVideoOptionsSheet(context),
                child: Icon(
                  Icons.more_vert,
                  color: context.yt.textSecondary,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// builds the shorts section with horizontal thumbnails
Widget buildShortsSection(BuildContext context, List<ShortThumbnail> shorts) {
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
              style: th.YtText.sectionHeader.copyWith(
                color: context.yt.textPrimary,
              ),
            ),
            // Icon(Icons.chevron_right, color: context.yt.textSecondary),
            const Spacer(),
            GestureDetector(
              onTap: () => showSectionOptionsSheet(context),
              child: Icon(
                Icons.more_vert,
                color: context.yt.textSecondary,
                size: 20,
                weight: 1000,
              ),
            ),
          ],
        ),
      ),

      SizedBox(
        height: 284,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: shorts.length,
          itemBuilder: (context, index) {
            final short = shorts[index];
            return _buildShortThumbnail(
              context: context,
              title: short.title,
              views: short.views,
              imagePath: short.imagePath,
            );
          },
        ),
      ),

      const SizedBox(height: 8),
    ],
  );
}

Widget buildShortsGridSection(
  BuildContext context,
  List<ShortThumbnail> shorts,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ---------- Shorts Header ----------
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
              style: th.YtText.sectionHeader.copyWith(
                color: context.yt.textPrimary,
              ),
            ),

            const Spacer(),

            GestureDetector(
              onTap: () => showSectionOptionsSheet(context),
              child: Icon(
                Icons.more_vert,
                color: context.yt.textSecondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),

      // ---------- Shorts Grid ----------
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shorts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 9 / 16,
          ),
          itemBuilder: (context, index) {
            final short = shorts[index];
            return _buildShortThumbnail(
              context: context,
              title: short.title,
              views: short.views,
              imagePath: short.imagePath,
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
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              shortsPageFrame(onBack: () => Navigator.pop(context)),
        ),
      );
    },
    child: Container(
      width: 160,
      height: 160 * 16 / 9,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Thumbnail
            Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),

            // Menu Button
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: () => showSectionOptionsSheet(context),
                child: Icon(Icons.more_vert, color: Colors.white, size: 20),
              ),
            ),

            // Title overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 18, 10, 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xE6000000), Colors.transparent],
                    stops: [0.0, 0.9],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: th.YtText.shortsTitle.copyWith(
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      views,
                      style: th.YtText.shortsMeta.copyWith(
                        color: Colors.white70,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// shows youtube-style bottom sheet with video options
void showVideoOptionsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: context.yt.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final items = [
        (Icons.playlist_play, 'Play next in queue'),
        (Icons.watch_later_outlined, 'Save to Watch Later'),
        (Icons.bookmark_border, 'Save to playlist'),
        (Icons.download_outlined, 'Download video'),
        (Icons.share_outlined, 'Share'),
        (Icons.block, 'Not interested'),
        (Icons.not_interested, "Don't recommend channel"),
        (Icons.flag_outlined, 'Report'),
      ];

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 219, 219),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...items.map(
              (item) => InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 11,
                  ),
                  child: Row(
                    children: [
                      Icon(item.$1, color: context.yt.textPrimary, size: 26),
                      const SizedBox(width: 20),
                      Text(
                        item.$2,
                        style: th.YtText.settingsSection.copyWith(
                          color: context.yt.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// shows youtube-style bottom sheet for posts/sections with limited options
void showSectionOptionsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: context.yt.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final items = [
        (Icons.block, 'Not interested'),
        (Icons.not_interested, "Don't recommend this channel"),
        (Icons.flag_outlined, 'Report'),
      ];

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 219, 219),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...items.map(
              (item) => InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 11,
                  ),
                  child: Row(
                    children: [
                      Icon(item.$1, color: context.yt.textPrimary, size: 26),
                      const SizedBox(width: 20),
                      Text(
                        item.$2,
                        style: th.YtText.settingsSection.copyWith(
                          color: context.yt.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
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
            style: th.YtText.caption.copyWith(
              color: context.yt.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
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
                  style: th.YtText.caption.copyWith(
                    color: context.yt.textPrimary,
                    fontSize: 13,
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

// community post widget with like toggle and expandable description
class CommunityPost extends StatefulWidget {
  final String channelName;
  final String profileImage;
  final String timeAgo;
  final String description;
  final String postImage;

  const CommunityPost({
    super.key,
    required this.channelName,
    required this.profileImage,
    required this.timeAgo,
    required this.description,
    required this.postImage,
  });

  @override
  State<CommunityPost> createState() => _CommunityPostState();
}

class _CommunityPostState extends State<CommunityPost> {
  bool isLiked = false;
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // channel header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.profileImage),
                radius: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.channelName,
                        style: th.YtText.bodyMedium.copyWith(
                          color: context.yt.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: "  •  ${widget.timeAgo}",
                        style: th.YtText.videoMeta.copyWith(
                          color: context.yt.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showSectionOptionsSheet(context),
                child: Icon(
                  Icons.more_vert,
                  color: context.yt.textSecondary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),

        // description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.description,
                maxLines: expanded ? null : 2,
                overflow: expanded ? null : TextOverflow.ellipsis,
                style: th.YtText.body.copyWith(color: context.yt.textPrimary),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => setState(() => expanded = !expanded),
                child: Text(
                  expanded ? "Show less" : "Read more",
                  style: th.YtText.label.copyWith(
                    color: context.yt.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // post image
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Image.asset(
            widget.postImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 8),

        // actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                  color: context.yt.textPrimary,
                ),
                onPressed: () => setState(() => isLiked = !isLiked),
              ),
              IconButton(
                icon: Icon(
                  Icons.thumb_down_alt_outlined,
                  color: context.yt.textPrimary,
                ),
                onPressed: () {},
              ),
              const Spacer(),
              Icon(Icons.share_outlined, color: context.yt.textPrimary),
              const SizedBox(width: 20),
              Icon(Icons.mode_comment_outlined, color: context.yt.textPrimary),
            ],
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}

Widget buildBentoExplore(BuildContext context) {
  return GridView.custom(
    gridDelegate: SliverQuiltedGridDelegate(
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      repeatPattern: QuiltedGridRepeatPattern.inverted,
      pattern: [
        QuiltedGridTile(1, 1),
        QuiltedGridTile(1, 1),
        QuiltedGridTile(2, 1),
        QuiltedGridTile(1, 1),
        QuiltedGridTile(1, 1),

        // QuiltedGridTile(2, 1),
        // QuiltedGridTile(2, 1),
        // QuiltedGridTile(1, 2),
      ],
    ),
    childrenDelegate: SliverChildBuilderDelegate(
      (context, index) => _BentoTile(index: index),
    ),
  );
}
