import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme_yt.dart' as th;
import 'homePage.dart';
import 'createPage.dart';
import 'subscriptionPage.dart';
import 'libraryPage.dart';
import 'shortsPage.dart';
import 'main.dart';

final GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

class ContainerFrame extends StatefulWidget {
  const ContainerFrame({super.key, required this.title});

  final String title;

  @override
  State<ContainerFrame> createState() => _ContainerFrameState();
}

class _ContainerFrameState extends State<ContainerFrame> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    homePageFrame(),
    Container(),
    createPageFrame(),
    subsPageFrame(),
    libraryPageFrame(),
  ];

  // handles bottom nav tap
  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const shortsPageFrame()),
      );
      return;
    }

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
        drawerEdgeDragWidth: 40,
        drawerEnableOpenDragGesture: true,
        drawer: _buildExploreDrawer(context),
        appBar: AppBar(
          title: _selectedIndex == 4
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/icons/logo_yt.png', height: 32),
                    SizedBox(width: 8),
                    Flexible(child: Text(widget.title)),
                  ],
                ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.cast)),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            if (_selectedIndex == 4)
              IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
            IconButton(
              onPressed: () {
                themeNotifier.value = themeNotifier.value == ThemeMode.light
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
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Builder(
                builder: (context) => SvgPicture.asset(
                  'assets/icons/shorts24x_outline.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.yt.iconInactive,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: Builder(
                builder: (context) => SvgPicture.asset(
                  'assets/icons/shorts24x_filled.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.yt.iconActive,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Shorts",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 35),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: "Subscriptions",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: "You",
            ),
          ],
        ),
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
    {
      'label': 'YouTube Studio',
      'image':
          'https://play-lh.googleusercontent.com/MFXGM-LMDsCqBMVgMPSAjFwM1Gm_mMqDKjBaBcGbcDqMTnR1VEqElYlNyp4XEJzUQ=w240-h480-rw',
    },
    {
      'label': 'YouTube Music',
      'image':
          'https://play-lh.googleusercontent.com/GnYnNfKBr2nysHBYgYRCQtcv_RRNN0Sosn47F5ArKJu89DMR3_jHRAazoIVsPUoaMg=w240-h480-rw',
    },
    {
      'label': 'YouTube Kids',
      'image':
          'https://play-lh.googleusercontent.com/ZS5E4BzZVgIaKEdFnYqz_yDDMGRUlGJGrBB0Cg0WAuRLMBuCmcEMcLUqBdaySaEf4g=w240-h480-rw',
    },
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
                style: TextStyle(
                  color: context.yt.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
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
                    style: TextStyle(
                      color: context.yt.textPrimary,
                      fontSize: 15,
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
                    child: Image.network(
                      app['image']!,
                      width: 26,
                      height: 26,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.play_circle_outline,
                        color: Colors.red,
                        size: 26,
                      ),
                    ),
                  ),
                  title: Text(
                    app['label']!,
                    style: TextStyle(
                      color: context.yt.textPrimary,
                      fontSize: 15,
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
            style: TextStyle(color: context.yt.textSecondary, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
