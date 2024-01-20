import 'dart:developer';

import 'package:snapvalt/app/core/utils/assets_path.dart';
import 'package:snapvalt/app/core/utils/common_functions.dart';
import 'package:snapvalt/app/core/utils/constants.dart';
import 'package:snapvalt/app/core/utils/enums.dart';
import 'package:snapvalt/app/core/utils/screen_sizes.dart';
import 'package:snapvalt/app/provider/menu_provider.dart';
import 'package:snapvalt/app/provider/theme_provider.dart';
import 'package:snapvalt/app/view/menu_screen/widget/menu_item.dart';
import 'package:snapvalt/app/view/menu_screen/widget/sub_menu_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
    required this.maxWidth,
    required this.mainScreens,
    required this.subScreen,
    this.isMobileScreen = false,
  });
  final double maxWidth;
  final MAIN_SCREENS mainScreens;
  final SUB_SCREENS subScreen;
  final bool isMobileScreen;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  List<AnimationController> _animationControllers = [];
  List<Animation<double>> _animationList = [];
  late final List<AnimationController> _iconAnimationControllerList;
  late final List<Animation<double>> _iconAnimationList;
  late MenuProvider menuProvider;
  Map<String, dynamic> menuList = {
    "Movies": {
      "icon": Assets.moviesIcon,
      "labels": ["Popular", "Top Rated", "Now Playing"],
      "mainRoutes": "/dashboard/movies/popular",
      "routes": ["/dashboard/movies/popular", "/dashboard/movies/topRated", "/dashboard/movies/nowPlaying"],
    },
    "TV Series": {
      "icon": Assets.tvSeriesIcon,
      "labels": ["Popular", "Top Rated", "Now Playing"],
      "mainRoutes": "/dashboard/tvSeries/popular",
      "routes": ["/dashboard/tvSeries/popular", "/dashboard/tvSeries/topRated", "/dashboard/tvSeries/nowPlaying"],
    },
    "Celebrities": {
      "icon": Assets.celebritiesIcon,
      "labels": ["Popular", "Top Rated"],
      "mainRoutes": "/dashboard/celebrities/popular",
      "routes": ["/dashboard/celebrities/popular", "/dashboard/celebrities/topRated"],
    }
  };

  @override
  void initState() {
    super.initState();
    menuProvider = Provider.of<MenuProvider>(context, listen: false);
    generateControllers();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      expandMenu();
    });
  }

  generateControllers() {
    /// Create animation controllers for each main menu
    _animationControllers = List.generate(
        menuList.length,
            (index) => AnimationController(
          duration: const Duration(milliseconds: 600),
          vsync: this,
        ));

    _animationList = List.generate(
        menuList.length,
            (index) => CurvedAnimation(
          parent: _animationControllers[index],
          curve: Curves.fastOutSlowIn,
        ));

    _iconAnimationControllerList = List.generate(
      menuList.length,
          (index) => AnimationController(duration: const Duration(milliseconds: 300), vsync: this),
    );

    _iconAnimationList = List.generate(
      menuList.length,
          (index) => Tween(begin: 0.0, end: .25).animate(
        CurvedAnimation(parent: _iconAnimationControllerList[index], curve: Curves.easeOut),
      ),
    );
  }

  expandMenu() {
    int index = 0;
    int subIndex = 0;
    if (widget.mainScreens == MAIN_SCREENS.movies) {
      index = 0;
      if (widget.subScreen == SUB_SCREENS.popular) {
        subIndex = 0;
      } else if (widget.subScreen == SUB_SCREENS.topRated) {
        subIndex = 1;
      } else if (widget.subScreen == SUB_SCREENS.nowPlaying) {
        subIndex = 2;
      }
    } else if (widget.mainScreens == MAIN_SCREENS.tvSeries) {
      index = 1;
      if (widget.subScreen == SUB_SCREENS.popular) {
        subIndex = 0;
      } else if (widget.subScreen == SUB_SCREENS.topRated) {
        subIndex = 1;
      } else if (widget.subScreen == SUB_SCREENS.nowPlaying) {
        subIndex = 2;
      }
    } else if (widget.mainScreens == MAIN_SCREENS.celebrities) {
      index = 2;
      if (widget.subScreen == SUB_SCREENS.popular) {
        subIndex = 0;
      } else if (widget.subScreen == SUB_SCREENS.topRated) {
        subIndex = 1;
      }
    }

    /// Expand Menu
    for (int i = 0; i < _animationControllers.length; i++) {
      /// When a menu item is unselected, it should be closed to ensure a clean
      /// and uncluttered user interface.
      if (i != index) {
        _animationControllers[i].reverse();
        _iconAnimationControllerList[i].reverse();
      }
    }
    _iconAnimationList[index].isDismissed ? _iconAnimationControllerList[index].forward() : _iconAnimationControllerList[index].reverse();
    _animationControllers[index].isDismissed ? _animationControllers[index].forward() : _animationControllers[index].reverse();

    menuProvider.setSelectedMenuIndex = index;
    menuProvider.setSelectedSubMenuIndex = subIndex;
  }

  @override
  void dispose() {
    /// Dispose controllers to avoid memory leaks
    for (AnimationController controller in _animationControllers) {
      controller.dispose();
    }
    for (AnimationController controller in _iconAnimationControllerList) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDesktopScreen = isDesktop(screenWidth: widget.maxWidth);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Movies",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontFamily: Constants.montserratSemiBold),
            ),
            Visibility(
              visible: !isDesktopScreen,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    Assets.closeIcon,
                    fit: BoxFit.contain,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Consumer<MenuProvider>(builder: (context, menuProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(
              menuList.length,
                  (index) {
                final String menuLabel = menuList.keys.elementAt(index);

                final Map<String, dynamic> itemMapObject = menuList.values.elementAt(index);
                final String icon = itemMapObject["icon"];

                /// Converting List<dynamic> to List<String>
                List<dynamic> dynamicSubMenuList = itemMapObject["labels"];
                List<String> subMenuList = dynamicSubMenuList.map((element) => element.toString()).toList();
                List<dynamic> dynamicRoutesList = itemMapObject["routes"];
                List<String> routesList = dynamicRoutesList.map((element) => element.toString()).toList();
                String mainScreen = itemMapObject["mainRoutes"];
                bool isSelectedItem = menuProvider.selectedMenuIndex == index;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        log("Main URL: $mainScreen");
                        CommonFunctions().clearALLData(context: context);
                        GoRouter.of(context).go(mainScreen);
                        for (int i = 0; i < _animationControllers.length; i++) {
                          if (i != index) {
                            _animationControllers[i].reverse();
                            _iconAnimationControllerList[i].reverse();
                          }
                        }
                        _iconAnimationList[index].isDismissed ?
                        _iconAnimationControllerList[index].forward() : _iconAnimationControllerList[index].reverse();
                        _animationControllers[index].isDismissed ?
                        _animationControllers[index].forward() : _animationControllers[index].reverse();

                        menuProvider.setSelectedMenuIndex = index;
                        menuProvider.setSelectedSubMenuIndex = 0;

                      },
                      child: MenuItem(
                        label: menuLabel,
                        isSelectedItem: isSelectedItem,
                        icon: icon,
                        textStyle: themeProvider.titleMedium!,
                        animation: _iconAnimationList[index],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizeTransition(
                      sizeFactor: _animationList[index],
                      axis: Axis.vertical,
                      axisAlignment: 1,
                      child: SubMenuList(
                        labels: subMenuList,
                        maxWidth: widget.maxWidth,
                        routes: routesList,
                        isSelectedSubMenuItem: isSelectedItem,
                        selectedSubMenuItemIndex: menuProvider.selectedSubMenuIndex,
                        isMobileScreen: widget.isMobileScreen,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }
}
