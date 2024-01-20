import 'package:snapvalt/app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.isDesktopScreen, required this.title, required this.subTitle});

  final bool isDesktopScreen;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: themeProvider.titleBig?.copyWith(fontSize: isDesktopScreen ? 20 : 18),
          ),
          const SizedBox(height: 6),
          Text(
            subTitle,
            style: themeProvider.titleMedium?.copyWith(fontSize: isDesktopScreen ? 16 : 12),
          ),
        ],
      );
    });
  }
}
