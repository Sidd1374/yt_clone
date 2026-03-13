import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme_yt.dart' as th;
import 'homePage.dart';
import 'createPage.dart';
import 'subscriptionPage.dart';
import 'libraryPage.dart';
import 'shortsPage.dart';
import 'search_page.dart';
import 'main.dart';
import 'explore_Bento.dart';

final GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

class ContainerFrame extends StatefulWidget {
  const ContainerFrame({super.key, required this.title});

  final String title;

  @override
  State<ContainerFrame> createState() => _ContainerFrameState();
}

class _ContainerFrameState extends State<ContainerFrame> {
  int _selectedIndex = 0;

  List<Widget> get _widgetOptions => <Widget>[
    homePageFrame(),
    shortsPageFrame(
      onBack: () {
        setState(() => _selectedIndex = 0);
      },
    ),
    createPageFrame(),
    subsPageFrame(),
    libraryPageFrame(),
  ];

  // handles bottom nav tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        key: rootScaffoldKey,
        drawerEdgeDragWidth: 0,
        drawerEnableOpenDragGesture: false,
        drawer: _buildExploreDrawer(context),
        appBar: _selectedIndex == 1
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                title: _selectedIndex == 4
                    ? null
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/icons/logo_yt.png', height: 22),
                          SizedBox(width: 2),
                          Flexible(child: Text(widget.title)),
                        ],
                      ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ExploreBento()),
                      );
                    },
                    icon: Icon(Icons.cast),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SearchPage()),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                  if (_selectedIndex == 4)
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const _SettingsPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.settings_outlined),
                    ),
                  if (_selectedIndex == 4)
                    IconButton(
                      onPressed: () {
                        themeNotifier.value =
                            themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                      icon: Icon(Icons.brightness_6),
                    ),
                ],
              ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              activeIcon: Icon(Icons.home_filled, size: 28),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Builder(
                builder: (context) => SvgPicture.asset(
                  'assets/icons/shorts24x_outline.svg',
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(
                    context.yt.iconInactive,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: Builder(
                builder: (context) => SvgPicture.asset(
                  'assets/icons/shorts24x_filled.svg',
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(
                    context.yt.iconActive,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Shorts",
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(9),
                child: Icon(Icons.add, size: 28),
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined, size: 28),
              activeIcon: Icon(Icons.subscriptions, size: 28),
              label: "Subscriptions",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, size: 28),
              activeIcon: Icon(Icons.account_circle, size: 28),
              label: "You",
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).extension<th.YtColors>()!.textPrimary,
      ),
      title: Text(
        title,
        style: th.YtText.settingsItem.copyWith(
          color: Theme.of(context).extension<th.YtColors>()!.textPrimary,
        ),
      ),
      minLeadingWidth: 24,
      minTileHeight: 48,
      horizontalTitleGap: 16,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      onTap: onTap,
    );
  }

  Widget _section(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
          child: Text(
            title,
            style: th.YtText.settingsSection.copyWith(
              color: Theme.of(context).extension<th.YtColors>()!.textPrimary,
            ),
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
        titleSpacing: 0,
        title: const Text("Settings"),
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          _section(context, "Account", [
            _item(context, Icons.settings, "General", () {}),
            _item(context, Icons.switch_account, "Switch account", () {}),
            _item(context, Icons.family_restroom, "Family Centre", () {}),
            _item(context, Icons.language, "Languages", () {}),
            _item(context, Icons.timer, "Time management", () {}),
            _item(context, Icons.notifications, "Notifications", () {}),
            _item(context, Icons.credit_card, "Billing and payments", () {}),
            _item(context, Icons.history, "Manage all history", () {}),
            _item(context, Icons.lock, "Privacy", () {}),
            _item(context, Icons.link, "Connected apps", () {}),
          ]),
          const SizedBox(height: 6),
          _section(context, "Video and audio preferences", [
            _item(context, Icons.hd, "Quality", () {}),
            _item(context, Icons.play_arrow, "Playback", () {}),
            _item(context, Icons.closed_caption, "Captions", () {}),
            _item(context, Icons.tune, "Data saving", () {}),
            _item(context, Icons.download, "Background and downloads", () {}),
            _item(context, Icons.chat, "Live chat", () {}),
            _item(context, Icons.accessibility, "Accessibility", () {}),
            _item(context, Icons.tv, "Watch on TV", () {}),
          ]),
          const SizedBox(height: 6),
          _section(context, "Help and policy", [
            _item(context, Icons.help_outline, "Help", () {}),
            _item(
              context,
              Icons.description,
              "YouTube Terms of Service",
              () {},
            ),
            _item(context, Icons.feedback, "Send feedback", () {}),
            _item(context, Icons.info_outline, "About", () {}),
          ]),
        ],
      ),
    );
  }
}

// builds the explore drawer
Widget _buildExploreDrawer(BuildContext context) {
  final List<Map<String, dynamic>> drawerCategories = [
    {'icon': Icons.shopping_bag_outlined, 'label': 'Shopping'},
    {'icon': Icons.music_note_outlined, 'label': 'Music'},
    {'icon': Icons.movie_outlined, 'label': 'Films'},
    {'icon': Icons.auto_awesome_outlined, 'label': 'Hype'},
    {'icon': Icons.sensors_outlined, 'label': 'Live'},
    {'icon': Icons.sports_esports_outlined, 'label': 'Gaming'},
    {'icon': Icons.newspaper_outlined, 'label': 'News'},
    {'icon': Icons.emoji_events_outlined, 'label': 'Sport'},
    {'icon': Icons.school_outlined, 'label': 'Courses'},
    {'icon': Icons.dry_cleaning_outlined, 'label': 'Fashion & beauty'},
    {'icon': Icons.podcasts_outlined, 'label': 'Podcasts'},
    {'icon': Icons.grid_view_rounded, 'label': 'Playables'},
  ];

  final List<Map<String, String>> ytApps = [
    {'label': 'YouTube Studio', 'image': 'assets/icons/yt_studio_logo.svg'},
    {'label': 'YouTube Music', 'image': 'assets/icons/yt_music_logo.svg'},
    {'label': 'YouTube Kids', 'image': 'assets/icons/yt_kids_logo.svg'},
  ];

  return Drawer(
    width: MediaQuery.of(context).size.width * 0.75,
    backgroundColor: context.yt.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // premium header
        Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            MediaQuery.of(context).padding.top + 16,
            16,
            12,
          ),
          child: Row(
            children: [
              Image.asset('assets/icons/logo_yt.png', height: 24),
              const SizedBox(width: 4),
              Text(
                "Premium",
                style: th.YtText.appBarTitle.copyWith(
                  color: context.yt.textPrimary,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        // category and app list
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ...drawerCategories.map(
                (cat) => ListTile(
                  leading: Icon(
                    cat['icon'],
                    color: context.yt.textPrimary,
                    size: 26,
                  ),
                  title: Text(
                    cat['label'],
                    style: th.YtText.settingsItem.copyWith(
                      color: context.yt.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  minVerticalPadding: 12,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: context.yt.divider, height: 1),
              ),
              ...ytApps.map(
                (app) => ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SvgPicture.asset(
                      app['image']!,
                      width: 26,
                      height: 26,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.play_circle_outline,
                        // color: Colors.red,
                        size: 26,
                      ),
                    ),
                  ),
                  title: Text(
                    app['label']!,
                    style: th.YtText.settingsItem.copyWith(
                      color: context.yt.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  minVerticalPadding: 12,
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
        // footer
        Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            12,
            16,
            MediaQuery.of(context).padding.bottom + 12,
          ),
          child: Text(
            'Privacy Policy \u00B7 Terms of Service',
            style: th.YtText.videoMeta.copyWith(
              color: context.yt.textSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}
