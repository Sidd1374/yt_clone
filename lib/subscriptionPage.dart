import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;

class subsPageFrame extends StatelessWidget {
  const subsPageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: th.ytBackground,
      body: Center(
        child: Text("This is subsPage",
          style: TextStyle(color: th.ytTextPrimary),
        ),
      ),
    );
  }
}
