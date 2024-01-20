import 'package:snapvalt/app/core/utils/enums.dart';
import 'package:snapvalt/app/core/utils/screen_sizes.dart';
import 'package:snapvalt/app/provider/theme_provider.dart';
import 'package:snapvalt/app/view/celebrities_screen/celebrities_screen.dart';
import 'package:snapvalt/app/view/menu_screen/menu_screen.dart';
import 'package:snapvalt/app/view/movies_screen/movies_screen.dart';
import 'package:snapvalt/app/view/tv_series_screen/tv_series_screen.dart';
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
      padding: EdgeInsets.all(isDesktopScreen ? 6 : 0),
      decoration: BoxDecoration(
        color: themeProvider.colorScheme?.primaryContainer,
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
                switch (widget.mainScreen) {
                  case MAIN_SCREENS.movies:
                    return returnMoviesScreen(subScreen: widget.subScreen, maxWidth: widget.maxWidthAndHeight.maxWidth);
                  case MAIN_SCREENS.tvSeries:
                    return returnTVSeriesScreen(subScreen: widget.subScreen, maxWidth: widget.maxWidthAndHeight.maxWidth);
                  case MAIN_SCREENS.celebrities:
                    return returnCelebScreen(subScreen: widget.subScreen, maxWidth: widget.maxWidthAndHeight.maxWidth);
                  default:
                    return returnMoviesScreen(subScreen: widget.subScreen, maxWidth: widget.maxWidthAndHeight.maxWidth);
                }
               },
            ),
          ),
        ],
      ),
    );
  }

  returnMoviesScreen({required SUB_SCREENS subScreen, required double maxWidth}) {
    switch (subScreen) {
      case SUB_SCREENS.popular:
        return MoviesScreen(maxWidth: maxWidth);
      case SUB_SCREENS.topRated:
        return MoviesScreen(maxWidth: maxWidth);
      case SUB_SCREENS.nowPlaying:
        return MoviesScreen(maxWidth: maxWidth);
      default:
        return MoviesScreen(maxWidth: maxWidth);
    }
  }
  returnTVSeriesScreen({required SUB_SCREENS subScreen, required double maxWidth}) {
    switch (subScreen) {
      case SUB_SCREENS.popular:
        return TVSeriesScreen(maxWidth: maxWidth, subScreen: SUB_SCREENS.popular);
      case SUB_SCREENS.topRated:
        return TVSeriesScreen(maxWidth: maxWidth, subScreen: SUB_SCREENS.topRated);
      case SUB_SCREENS.nowPlaying:
        return TVSeriesScreen(maxWidth: maxWidth, subScreen: SUB_SCREENS.nowPlaying);
      default:
        return TVSeriesScreen(maxWidth: maxWidth, subScreen: SUB_SCREENS.popular);
    }
  }
  returnCelebScreen({required SUB_SCREENS subScreen, required double maxWidth}) {
    switch (subScreen) {
      case SUB_SCREENS.popular:
        return CelebritiesScreen(maxWidth: maxWidth);
      case SUB_SCREENS.topRated:
        return CelebritiesScreen(maxWidth: maxWidth);
      default:
        return CelebritiesScreen(maxWidth: maxWidth);
    }
  }
}
