import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'theme_yt.dart' as th;
import 'yt_widgets.dart';

// data model for a single short
class _ShortData {
  final String videoAsset;
  final String title;
  final String channel;
  final String profileImage;
  final String likes;
  final String comments;
  final String audio;

  const _ShortData({
    required this.videoAsset,
    required this.title,
    required this.channel,
    required this.profileImage,
    required this.likes,
    required this.comments,
    required this.audio,
  });
}

class shortsPageFrame extends StatefulWidget {
  const shortsPageFrame({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<shortsPageFrame> createState() => _shortsPageFrameState();
}

class _shortsPageFrameState extends State<shortsPageFrame> {
  late PageController _pageController;
  int _currentPage = 0;

  // sample shorts data (all use the same video asset for now)
  final List<_ShortData> _shorts = const [
    _ShortData(
      videoAsset: 'assets/videos/Final_Reel_01.mp4',
      title: 'This is a sample Short video title 🔥',
      channel: '@channelname',
      profileImage: 'assets/images/pi1.png',
      likes: '49',
      comments: '2',
      audio: 'Original audio - channelname',
    ),
    _ShortData(
      videoAsset: 'assets/videos/Final_Reel_01.mp4',
      title: 'Another trending Short 🚀',
      channel: '@creator2',
      profileImage: 'assets/images/pi1.png',
      likes: '1.2K',
      comments: '38',
      audio: 'Trending sound - creator2',
    ),
    _ShortData(
      videoAsset: 'assets/videos/Final_Reel_01.mp4',
      title: 'You won\'t believe this! 😱',
      channel: '@viral_clips',
      profileImage: 'assets/images/pi1.png',
      likes: '5.6K',
      comments: '120',
      audio: 'Original audio - viral_clips',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // vertical swipeable page view
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _shorts.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return _ShortVideoPage(
                data: _shorts[index],
                isActive: index == _currentPage,
              );
            },
          ),

          // top bar (always visible)
          Positioned(
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (widget.onBack != null) {
                          widget.onBack!();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const Text(
                      "Shorts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/option_vertical.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
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
  }
}

// individual short video page with its own controller
class _ShortVideoPage extends StatefulWidget {
  final _ShortData data;
  final bool isActive;

  const _ShortVideoPage({required this.data, required this.isActive});

  @override
  State<_ShortVideoPage> createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<_ShortVideoPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showPauseIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.data.videoAsset)
      ..setLooping(true)
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _isInitialized = true);
          if (widget.isActive) _controller.play();
        }
      });
  }

  @override
  void didUpdateWidget(covariant _ShortVideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.seekTo(Duration.zero);
      _controller.play();
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showPauseIcon = true;
      } else {
        _controller.play();
        _showPauseIcon = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // video player with tap & long press
        if (_isInitialized)
          GestureDetector(
            onTap: _togglePlayPause,
            onLongPress: () => showVideoOptionsSheet(context),
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        else
          const Center(child: CircularProgressIndicator(color: Colors.white)),

        // pause icon overlay
        if (_showPauseIcon)
          const Center(
            child: Icon(Icons.pause_rounded, color: Colors.white70, size: 72),
          ),

        // gradient overlay
        const IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black54,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: SizedBox.expand(),
          ),
        ),

        // right side action buttons
        Positioned(
          right: 8,
          bottom: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionButton(
                context,
                Icons.thumb_up_outlined,
                widget.data.likes,
              ),
              const SizedBox(height: 16),
              _buildSvgActionButton(
                context,
                'assets/icons/dislike_yt.svg',
                "Dislike",
              ),
              const SizedBox(height: 16),
              _buildSvgActionButton(
                context,
                'assets/icons/comment_outline.svg',
                widget.data.comments,
              ),
              const SizedBox(height: 16),
              _buildSvgActionButton(
                context,
                'assets/icons/forward.svg',
                "Share",
              ),
              const SizedBox(height: 16),
              _buildActionButton(context, Icons.loop, "Remix"),
              const SizedBox(height: 16),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white, width: 1.5),
                  image: DecorationImage(
                    image: AssetImage(widget.data.profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),

        // bottom info section
        Positioned(
          left: 12,
          right: 56,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.data.profileImage),
                    radius: 14,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.data.channel,
                    style: th.YtText.bodyMedium.copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Subscribe",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.data.title,
                style: th.YtText.videoTitle.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.data.audio,
                      style: th.YtText.videoMeta.copyWith(
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// builds an icon action button with label
Widget _buildActionButton(BuildContext context, IconData icon, String label) {
  return SizedBox(
    width: 44,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 28),
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    ),
  );
}

// builds an svg action button with label
Widget _buildSvgActionButton(
  BuildContext context,
  String svgPath,
  String label,
) {
  return SizedBox(
    width: 44,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svgPath,
          width: 28,
          height: 28,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    ),
  );
}
