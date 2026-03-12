import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;
import 'package:flutter_svg/flutter_svg.dart';
import 'videoPlayerPage.dart';
import 'yt_widgets.dart';

class libraryPageFrame extends StatelessWidget {
  const libraryPageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            _buildProfileHeader(context),

            const SizedBox(height: 16),

            _buildActionChips(context),

            const SizedBox(height: 20),

            _buildSectionHeader(context, "History", showArrow: true),
            const SizedBox(height: 8),
            _buildHistoryRow(context),

            const SizedBox(height: 20),

            _buildPlaylistsHeader(context),
            const SizedBox(height: 8),
            _buildPlaylistsRow(context),

            const SizedBox(height: 12),

            _buildMenuItemImage(
              context,
              'assets/icons/videos_logo.svg',
              "Your videos",
            ),
            _buildMenuItemImage(
              context,
              'assets/icons/download.svg',
              "Downloads",
            ),
            _buildMenuItemImage(
              context,
              'assets/icons/films_logo.svg',
              "Films",
            ),
            _buildMenuItem(context, Icons.school_outlined, "Courses"),
            _buildMenuItem(context, Icons.content_cut, "Clips"),
            _buildMenuItemImage(
              context,
              'assets/icons/rewards_logo.svg',
              "Badges",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: context.yt.divider, height: 32),
            ),

            _buildMenuItemImage(
              context,
              'assets/icons/p_logo_yt.svg',
              "Premium benefits",
              applyColorFilter: false,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// profile header with avatar and name
Widget _buildProfileHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage('assets/images/pi1.png'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Siddharth sharma",
                style: TextStyle(
                  color: context.yt.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "@siddharthsharma6961",
                    style: th.YtText.videoMeta.copyWith(
                      color: context.yt.textSecondary,
                    ),
                  ),
                  Text(
                    "  •  ",
                    style: th.YtText.videoMeta.copyWith(
                      color: context.yt.textSecondary,
                    ),
                  ),
                  Text(
                    "View channel",
                    style: th.YtText.videoMeta.copyWith(
                      color: context.yt.textSecondary,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: context.yt.textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// action chips for account switching
Widget _buildActionChips(BuildContext context) {
  final chips = [
    {'icon': Icons.switch_account_outlined, 'label': 'Switch account'},
    {'icon': Icons.g_mobiledata, 'label': 'Google Account'},
    {'icon': Icons.security_outlined, 'label': 'Turn on Incognito'},
    {'icon': Icons.share_outlined, 'label': 'Share profile'},
  ];

  return SizedBox(
    height: 36,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: chips.length,
      itemBuilder: (context, index) {
        final chip = chips[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              chip['icon'] as IconData,
              size: 18,
              weight: 300,
              color: context.yt.textPrimary,
            ),
            label: Text(
              chip['label'] as String,
              style: th.YtText.body.copyWith(
                color: context.yt.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: context.yt.surfaceVariant,
              foregroundColor: context.yt.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: const Size(0, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        );
      },
    ),
  );
}

// section header with optional arrow
Widget _buildSectionHeader(
  BuildContext context,
  String title, {
  bool showArrow = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: context.yt.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (showArrow)
          Icon(Icons.chevron_right, color: context.yt.textPrimary, size: 24),
      ],
    ),
  );
}

// horizontal history thumbnails row
Widget _buildHistoryRow(BuildContext context) {
  final historyItems = [
    {
      'thumb': 'assets/images/th1.jpg',
      'title': 'Flutter 3.40 Released - What\'s New?',
      'channel': 'IBM Technology',
      'duration': '11:10',
      'type': '',
    },
    {
      'thumb': 'assets/images/th2.jpg',
      'title': 'Flutter 3.7 Release Highlights — LIVE',
      'channel': 'Beat The Hunger',
      'duration': '',
      'type': 'live',
    },
    {
      'thumb': 'assets/images/th1.jpg',
      'title': 'Flutter vs React Native: Which is Better for 2026?',
      'channel': 'Keegan Evans',
      'duration': '8:24',
      'type': '',
    },
    {
      'thumb': 'assets/images/th2.jpg',
      'title': 'Flutter State Management Guide',
      'channel': 'Flutter Dev',
      'duration': '',
      'type': 'short',
    },
  ];

  return SizedBox(
    height: 175,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        final item = historyItems[index];
        return _buildHistoryThumbnail(
          context: context,
          thumbnailPath: item['thumb']!,
          title: item['title']!,
          channelName: item['channel']!,
          duration: item['duration']!,
          type: item['type']!,
        );
      },
    ),
  );
}

// single history thumbnail card
Widget _buildHistoryThumbnail({
  required BuildContext context,
  required String thumbnailPath,
  required String title,
  required String channelName,
  required String duration,
  String type = '',
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(
            title: title,
            channelName: channelName,
            views: '',
            time: '',
            profileImage: 'assets/images/pi1.png',
          ),
        ),
      );
    },
    child: Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    thumbnailPath,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // badge: LIVE chip / Shorts chip / duration time chip
              if (type == 'live')
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.sensors,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'LIVE',
                          style: th.YtText.caption.copyWith(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (type == 'short')
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(200),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/shorts24x_color.svg',
                          width: 10,
                          height: 10,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Shorts',
                          style: th.YtText.caption.copyWith(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (duration.isNotEmpty)
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(200),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      duration,
                      style: th.YtText.caption.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  child: LinearProgressIndicator(
                    value: 0.4,
                    minHeight: 3,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Title + more button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: th.YtText.videoTitle.copyWith(
                    color: context.yt.textPrimary,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () => showVideoOptionsSheet(context),
                child: Icon(
                  Icons.more_vert,
                  color: context.yt.textSecondary,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            channelName,
            style: th.YtText.videoMeta.copyWith(
              color: context.yt.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

// playlists header with add button
Widget _buildPlaylistsHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Text(
          "Playlists",
          style: TextStyle(
            color: context.yt.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Icon(Icons.chevron_right, color: context.yt.textPrimary, size: 24),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add, color: context.yt.textPrimary, size: 28),
        ),
      ],
    ),
  );
}

// horizontal playlists row
Widget _buildPlaylistsRow(BuildContext context) {
  final playlists = [
    {
      'thumb': 'assets/images/th2.jpg',
      'title': 'Liked videos',
      'privacy': 'Private',
      'count': '2,390',
    },
    {
      'thumb': 'assets/images/th1.jpg',
      'title': 'Food',
      'privacy': 'Private · Playlist',
      'count': '9',
    },
    {
      'thumb': 'assets/images/th2.jpg',
      'title': 'Food',
      'privacy': 'Private · Playlist',
      'count': '5',
    },
    {
      'thumb': 'assets/images/th1.jpg',
      'title': 'Watch Later',
      'privacy': 'Private · Playlist',
      'count': '12',
    },
  ];

  return SizedBox(
    height: 180,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final item = playlists[index];
        return _buildPlaylistThumbnail(
          context: context,
          thumbnailPath: item['thumb']!,
          title: item['title']!,
          privacy: item['privacy']!,
          count: item['count']!,
          isLikedVideos: index == 0,
        );
      },
    ),
  );
}

// single playlist thumbnail card
Widget _buildPlaylistThumbnail({
  required BuildContext context,
  required String thumbnailPath,
  required String title,
  required String privacy,
  required String count,
  bool isLikedVideos = false,
}) {
  return Container(
    width: 180,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 108,
          child: Stack(
            children: [
              Positioned(
                left: 6,
                right: 6,
                top: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.yt.chipBg,
                    border: Border.all(color: context.yt.divider, width: 0.5),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 8,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        thumbnailPath,
                        width: 180,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (isLikedVideos)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(color: Colors.black.withAlpha(60)),
                          ),
                        ),
                      ),
                    Positioned(
                      left: isLikedVideos ? 8 : null,
                      right: isLikedVideos ? null : 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(180),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isLikedVideos)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.playlist_play,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            if (isLikedVideos)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.thumb_up,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            Text(
                              count,
                              style: th.YtText.caption.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: th.YtText.videoTitle.copyWith(
                  color: context.yt.textPrimary,
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () => showVideoOptionsSheet(context),
              child: Icon(
                Icons.more_vert,
                color: context.yt.textSecondary,
                size: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          privacy,
          style: th.YtText.videoMeta.copyWith(color: context.yt.textSecondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

// menu item with icon
Widget _buildMenuItem(
  BuildContext context,
  IconData icon,
  String label, {
  Color? iconColor,
}) {
  return ListTile(
    leading: Icon(icon, color: iconColor ?? context.yt.textPrimary, size: 26),
    title: Text(
      label,
      style: th.YtText.settingsItem.copyWith(
        color: context.yt.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    visualDensity: const VisualDensity(vertical: -1),
    onTap: () {},
  );
}

// menu item with image asset
Widget _buildMenuItemImage(
  BuildContext context,
  String assetPath,
  String label, {
  bool applyColorFilter = true,
}) {
  return ListTile(
    leading: SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
      colorFilter: applyColorFilter
          ? ColorFilter.mode(context.yt.textPrimary, BlendMode.srcIn)
          : null,
    ),
    title: Text(
      label,
      style: th.YtText.settingsItem.copyWith(
        color: context.yt.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    visualDensity: const VisualDensity(vertical: -1),
    onTap: () {},
  );
}
