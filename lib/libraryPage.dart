import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;


class libraryPageFrame extends StatelessWidget {
  const libraryPageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: th.ytBackground,
      body: Center(
        child: Text("This is libraryPage",
          style: TextStyle(color: th.ytTextPrimary),
        ),
      ),
    );
  }
}
