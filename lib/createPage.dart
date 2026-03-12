import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;

class createPageFrame extends StatelessWidget {
  const createPageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is CreatePage",
          style: TextStyle(color: context.yt.textPrimary),
        ),
      ),
    );
  }
}
