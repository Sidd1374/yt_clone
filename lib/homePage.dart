import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;

class homePageFrame extends StatelessWidget {
  const homePageFrame({super.key});

  @override
  Widget build(BuildContext context) {

    const List<String> _Cat = [
      'All',
      'Explore',
      'Techonogy',
      'APIs',
      'Music',
      'Podcasts',
      'AI',
      'Gaming'
    ];

    return Scaffold(
      backgroundColor: th.ytBackground,
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _Cat.length,
                itemBuilder: (context, index) {
                  return _buildChip(_Cat[index]);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    _buildVideo(
                      "Flutter Tutorial for Beginners",
                      "assets/th1.jpg",
                      "1.2M views",
                      "2 days ago",
                      "assets/pi1.png",
                    ),
                    _buildVideo(
                      "Flutter Tutorial for Beginners",
                      "assets/th2.jpg",
                      "1.2M views",
                      "2 days ago",
                      "assets/pi1.png",
                    ),
                    _buildVideo(
                      "Flutter Tutorial for Beginners",
                      "assets/th1.jpg",
                      "1.2M views",
                      "2 days ago",
                      "assets/pi1.png",
                    ),
                    _buildVideo(
                      "Flutter Tutorial for Beginners",
                      "assets/th2.jpg",
                      "1.2M views",
                      "2 days ago",
                      "assets/pi1.png",
                    ),
                    _buildVideo(
                      "Flutter Tutorial for Beginners",
                      "assets/th1.jpg",
                      "1.2M views",
                      "2 days ago",
                      "assets/pi1.png",
                    ),
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}


Widget _buildVideo(String text, String imgPath, String views, String time,String profileImage){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Image.asset(
            imgPath,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 8),
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
                      text,
                      style: TextStyle(
                        color: th.ytTextPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "$views • $time",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // More Options Icon
              const Icon(
                Icons.more_vert,
                color: Colors.grey,
              )
            ],
          ),
        ],
      ),
    );
}

Widget _buildChip(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: th.ytSurface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: th.ytTextPrimary,
          fontSize: 14,
        ),
      ),
    ),
  );
}
