import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class shortsPageFrame extends StatefulWidget {
  const shortsPageFrame({super.key});

  @override
  State<shortsPageFrame> createState() => _shortsPageFrameState();
}

class _shortsPageFrameState extends State<shortsPageFrame> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Final_Reel_01.mp4')
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // video player
          if (_isInitialized)
            GestureDetector(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          // gradient overlay
          IgnorePointer(
            child: Container(
              decoration: const BoxDecoration(
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
            ),
          ),
          // top bar
          Positioned(
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Text(
                      "Shorts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.white, size: 24),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/option_vertical.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
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

          // right side action buttons
          Positioned(
            right: 8,
            bottom: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionButton(context, Icons.thumb_up_outlined, "49"),
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
                  "2",
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
                // channel logo
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white, width: 1.5),
                    image: DecorationImage(
                      image: AssetImage('assets/images/pi1.png'),
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
                      backgroundImage: AssetImage('assets/images/pi1.png'),
                      radius: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "@channelname",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
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
                      child: Text(
                        "Subscribe",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // title
                Text(
                  "This is a sample Short video title 🔥",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                // audio info
                Row(
                  children: [
                    Icon(Icons.music_note, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "Original audio - channelname",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
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
      ),
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
              style: TextStyle(color: Colors.white, fontSize: 11),
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
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    ),
  );
}
