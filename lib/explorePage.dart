import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;


class explorePageFrame extends StatelessWidget {
  const explorePageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: th.ytBackground,
      body: Center(
        child: Text("This is explorePage",
          style: TextStyle(color: th.ytTextPrimary),
        ),
      ),
    );
  }
}
