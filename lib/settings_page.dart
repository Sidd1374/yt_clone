import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget item(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(title),
      dense: true,
      minLeadingWidth: 28,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }

  Widget section(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        ...children,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          section("Account", [
            item(Icons.settings, "General", () {}),
            item(Icons.switch_account, "Switch account", () {}),
            item(Icons.family_restroom, "Family Centre", () {}),
            item(Icons.language, "Languages", () {}),
            item(Icons.timer, "Time management", () {}),
            item(Icons.notifications, "Notifications", () {}),
            item(Icons.credit_card, "Billing and payments", () {}),
            item(Icons.history, "Manage all history", () {}),
            item(Icons.lock, "Privacy", () {}),
            item(Icons.link, "Connected apps", () {}),
          ]),

          section("Video and audio preferences", [
            item(Icons.hd, "Quality", () {}),
            item(Icons.play_arrow, "Playback", () {}),
            item(Icons.closed_caption, "Captions", () {}),
            item(Icons.tune, "Data saving", () {}),
            item(Icons.download, "Background and downloads", () {}),
            item(Icons.chat, "Live chat", () {}),
            item(Icons.accessibility, "Accessibility", () {}),
            item(Icons.tv, "Watch on TV", () {}),
          ]),

          section("Help and policy", [
            item(Icons.help_outline, "Help", () {}),
            item(Icons.description, "YouTube Terms of Service", () {}),
            item(Icons.feedback, "Send feedback", () {}),
            item(Icons.info_outline, "About", () {}),
          ]),
        ],
      ),
    );
  }
}
