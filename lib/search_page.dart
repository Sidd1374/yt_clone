import 'package:flutter/material.dart';

import 'theme_yt.dart' as th;

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const List<_SearchHistoryItem> _historyItems = [
    _SearchHistoryItem(
      text: 'flutter ui design',
      imagePath: 'assets/images/th1.jpg',
    ),
    _SearchHistoryItem(
      text: 'youtube clone in flutter',
      imagePath: 'assets/images/th2.jpg',
    ),
    _SearchHistoryItem(
      text: 'best dart tips 2026',
      imagePath: 'assets/images/th1.jpg',
    ),
    _SearchHistoryItem(
      text: 'mobile app animation ideas',
      imagePath: 'assets/images/th2.jpg',
    ),
    _SearchHistoryItem(
      text: 'how to build shorts page',
      imagePath: 'assets/images/th1.jpg',
    ),
    _SearchHistoryItem(
      text: 'youtube settings ui reference',
      imagePath: 'assets/images/th2.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.yt.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 12, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: context.yt.textPrimary,
                      size: 26,
                    ),
                    padding: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(
                      minWidth: 46,
                      minHeight: 46,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: context.yt.surfaceVariant,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Search YouTube',
                        style: th.YtText.body.copyWith(
                          color: context.yt.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: context.yt.surfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic_none,
                        color: context.yt.textPrimary,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 6, bottom: 24),
                itemCount: _historyItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final item = _historyItems[index];
                  return _SearchHistoryRow(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHistoryRow extends StatelessWidget {
  const _SearchHistoryRow({required this.item});

  final _SearchHistoryItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.history, size: 24, color: context.yt.textSecondary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.text,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: th.YtText.body.copyWith(
                  color: context.yt.textPrimary,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.imagePath,
                width: 56,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.north_west, size: 22, color: context.yt.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _SearchHistoryItem {
  const _SearchHistoryItem({required this.text, required this.imagePath});

  final String text;
  final String imagePath;
}
