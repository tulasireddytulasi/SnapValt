import 'package:snapvalt/app/core/utils/color_palette.dart';
import 'package:snapvalt/app/core/utils/enums.dart';
import 'package:snapvalt/app/core/utils/screen_sizes.dart';
import 'package:snapvalt/app/provider/theme_provider.dart';
import 'package:snapvalt/app/view/chat_screen/chat_screen.dart';
import 'package:snapvalt/app/view/menu_screen/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({
    super.key,
    required this.mainScreen,
    required this.subScreen,
    required this.maxWidthAndHeight,
  });

  final BoxConstraints maxWidthAndHeight;
  final MAIN_SCREENS mainScreen;
  final SUB_SCREENS subScreen;

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final double maxWidth = widget.maxWidthAndHeight.maxWidth;
    bool isDesktopScreen = isDesktop(screenWidth: maxWidth);
    return Container(
      width: maxWidth,
      alignment: Alignment.topCenter,
      height: widget.maxWidthAndHeight.maxHeight,
      padding: EdgeInsets.all(isDesktopScreen ? 6 : 0),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: ColorPalette.primary,
        borderRadius: isDesktopScreen ? const BorderRadius.all(Radius.circular(20)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: maxWidth >= 700,
            child: Expanded(
              flex: maxWidth <= 800 ? 4 : 3,
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 20, left: 14),
                child: MenuScreen(
                  maxWidth: widget.maxWidthAndHeight.maxWidth,
                  mainScreens: widget.mainScreen,
                  subScreen: widget.subScreen,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ChatScreen(
                  maxWidth: maxWidth,
                  title: "Tulasi Reddy",
                  subTitle: "Online",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
