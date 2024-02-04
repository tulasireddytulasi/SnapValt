import 'package:snapvalt/app/core/utils/color_palette.dart';
import 'package:snapvalt/app/provider/movies_provider.dart';
import 'package:snapvalt/app/provider/theme_provider.dart';
import 'package:snapvalt/app/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.maxWidth, required this.title, required this.subTitle});

  final double maxWidth;
  final String title;
  final String subTitle;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String keyButtonContinue = "create_button_continue";
  late ThemeProvider themeProvider;
  int customWidget = 1;

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktopScreen = widget.maxWidth >= 652;
    return Consumer<MoviesProvider>(builder: (context, MoviesProvider, child) {
      return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(minHeight: 600),
        decoration: BoxDecoration(
          color: ColorPalette.primaryContainer,
          borderRadius: isDesktopScreen ? const BorderRadius.all(Radius.circular(14)) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(
              isDesktopScreen: isDesktopScreen,
              title: widget.title,
              subTitle: widget.subTitle,
            ),
            Divider(color: ColorPalette.blackPrimaryColor.shade100.withOpacity(0.4)),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: const Column(
                children: [
                  // MoviesProvider.currentWidget == 1
                  //     ? Widget1(
                  //         maxWidth: widget.maxWidth,
                  //       )
                  //     : const SizedBox.shrink(),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}