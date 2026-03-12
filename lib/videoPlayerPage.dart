import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'theme_yt.dart' as th;
import 'shortsPage.dart';
import 'yt_widgets.dart';

class VideoPlayerPage extends StatefulWidget {
  final String title;
  final String channelName;
  final String views;
  final String time;
  final String profileImage;
  final String? videoUrl;
  final String? videoAsset;

  const VideoPlayerPage({
    super.key,
    required this.title,
    required this.channelName,
    required this.views,
    required this.time,
    required this.profileImage,
    this.videoUrl,
    this.videoAsset,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  void _initVideoPlayer() {
    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl!),
      );
    } else if (widget.videoAsset != null && widget.videoAsset!.isNotEmpty) {
      _controller = VideoPlayerController.asset(widget.videoAsset!);
    } else {
      _controller = VideoPlayerController.asset(
        'assets/videos/Final_Reel_01.mp4',
      );
    }

    _controller.initialize().then((_) {
      setState(() {
        _isInitialized = true;
      });
      _controller.play();
    });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (d.inHours > 0) {
      return '${d.inHours}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.yt.background,
      body: SafeArea(
        child: Column(
          children: [
            // video player
            _buildVideoPlayer(context),
            // scrollable content below
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildVideoInfo(context),
                    _buildChannelRow(context),
                    _buildActionButtons(context),
                    Divider(color: context.yt.divider, height: 1),
                    _buildCommentsSection(context),
                    Divider(color: context.yt.divider, height: 1),
                    _buildRecommendedVideos(context),
                    _buildShortsSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // video player with controls
  Widget _buildVideoPlayer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showControls = !_showControls;
        });
      },
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 9 / 16,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            else
              const Center(child: CircularProgressIndicator(color: Colors.red)),

            // controls overlay
            if (_showControls) ...[
              // top bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.closed_caption_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cast,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),

              // play/pause controls
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.replay_10,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () {
                        final pos =
                            _controller.value.position -
                            const Duration(seconds: 10);
                        _controller.seekTo(
                          pos < Duration.zero ? Duration.zero : pos,
                        );
                      },
                    ),
                    const SizedBox(width: 24),
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 48,
                      ),
                      onPressed: () {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      },
                    ),
                    const SizedBox(width: 24),
                    IconButton(
                      icon: const Icon(
                        Icons.forward_10,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () {
                        final pos =
                            _controller.value.position +
                            const Duration(seconds: 10);
                        final max = _controller.value.duration;
                        _controller.seekTo(pos > max ? max : pos);
                      },
                    ),
                  ],
                ),
              ),

              // bottom progress bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isInitialized)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Text(
                                _formatDuration(_controller.value.position),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ' / ${_formatDuration(_controller.value.duration)}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      if (_isInitialized)
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Colors.red,
                            bufferedColor: Colors.white38,
                            backgroundColor: Colors.white24,
                          ),
                          padding: const EdgeInsets.only(bottom: 4),
                        ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              if (_isInitialized)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.red,
                      bufferedColor: Colors.white38,
                      backgroundColor: Colors.transparent,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  // video title and metadata
  Widget _buildVideoInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: context.yt.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.channelName}  ${widget.views}  ${widget.time}  ...more',
            style: th.YtText.videoMeta.copyWith(
              color: context.yt.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // channel avatar and subscribe button
  Widget _buildChannelRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(widget.profileImage),
            radius: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.channelName,
              style: th.YtText.bodyMedium.copyWith(
                color: context.yt.textPrimary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: context.yt.textPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Subscribe',
              style: th.YtText.button.copyWith(color: context.yt.background),
            ),
          ),
        ],
      ),
    );
  }

  // like, share, download action buttons
  Widget _buildActionButtons(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        children: [
          _actionButton(context, Icons.thumb_up_outlined, '70K'),
          _actionDivider(context),
          _actionButton(context, Icons.thumb_down_outlined, null),
          const SizedBox(width: 8),
          _actionButton(context, Icons.share_outlined, 'Share'),
          _actionButton(context, Icons.download_outlined, 'Download'),
          _actionButton(context, Icons.library_add_outlined, 'Remix'),
          _actionButton(context, Icons.content_cut_outlined, 'Clip'),
          _actionButton(context, Icons.bookmark_border, 'Save'),
          _actionButton(context, Icons.flag_outlined, 'Report'),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String? label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.yt.chipBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: context.yt.textPrimary, size: 18),
          if (label != null) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: th.YtText.label.copyWith(color: context.yt.textPrimary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _actionDivider(BuildContext context) {
    return Container(
      width: 1,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      color: context.yt.divider,
    );
  }

  // comments section with preview
  Widget _buildCommentsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Comments',
                style: th.YtText.bodyMedium.copyWith(
                  color: context.yt.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '2.7K',
                style: th.YtText.body.copyWith(color: context.yt.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.yt.chipBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: context.yt.chipSelectedBg,
                  child: Text(
                    'J',
                    style: th.YtText.caption.copyWith(
                      color: context.yt.chipSelectedText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'git push --force',
                        style: th.YtText.label.copyWith(
                          color: context.yt.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'John should know his place',
                        style: th.YtText.body.copyWith(
                          color: context.yt.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // recommended videos list
  Widget _buildRecommendedVideos(BuildContext context) {
    final List<Map<String, String>> recommendations = [
      {
        'title': 'The greatest unsolved problem in computer science...',
        'channel': 'Fireship',
        'views': '2.8 lakh views',
        'time': '23 hours ago',
        'thumbnail': 'assets/images/th2.jpg',
        'profile': 'assets/images/pi1.png',
      },
      {
        'title': 'How to Build a REST API with Flutter',
        'channel': 'Flutter Mapp',
        'views': '500K views',
        'time': '1 week ago',
        'thumbnail': 'assets/images/th1.jpg',
        'profile': 'assets/images/pi1.png',
      },
      {
        'title': 'Dart 3 Complete Tutorial for Beginners',
        'channel': 'Reso Coder',
        'views': '1.2M views',
        'time': '3 months ago',
        'thumbnail': 'assets/images/th2.jpg',
        'profile': 'assets/images/pi1.png',
      },
    ];

    return Column(
      children: recommendations.map((video) {
        return _buildRecommendedCard(context, video);
      }).toList(),
    );
  }

  // single recommended video card
  Widget _buildRecommendedCard(
    BuildContext context,
    Map<String, String> video,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(
              title: video['title']!,
              channelName: video['channel']!,
              views: video['views']!,
              time: video['time']!,
              profileImage: video['profile']!,
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
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      video['thumbnail']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '7:05',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(video['profile']!),
                  radius: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video['title']!,
                        style: th.YtText.videoTitle.copyWith(
                          color: context.yt.textPrimary,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${video['channel']} · ${video['views']} · ${video['time']}',
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

  // shorts section at bottom
  Widget _buildShortsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.play_arrow, color: Colors.red, size: 24),
              const SizedBox(width: 8),
              Text(
                'Shorts',
                style: TextStyle(
                  color: context.yt.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
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
            itemCount: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const shortsPageFrame(),
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
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          index.isEven
                              ? 'assets/images/th1.jpg'
                              : 'assets/images/th2.jpg',
                          fit: BoxFit.cover,
                        ),
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
                                  'Quantization explained #${index + 1}',
                                  style: th.YtText.shortsTitle.copyWith(
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${(index + 1) * 150}K views',
                                  style: th.YtText.shortsMeta.copyWith(
                                    color: Colors.white70,
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
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
