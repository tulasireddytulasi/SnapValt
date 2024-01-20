import 'package:snapvalt/app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    super.key,
    required this.label,
    required this.isSelectedItem,
    this.icon = "",
    this.margin = EdgeInsets.zero,
    required this.textStyle,
    this.animation,
  });

  final String icon;
  final String label;
  final bool isSelectedItem;
  final EdgeInsetsGeometry margin;
  final TextStyle textStyle;
  final Animation<double>? animation;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: widget.margin,
      decoration: widget.isSelectedItem
          ? ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, 0),
          end: const Alignment(1.00, -0.00),
          colors: [
            themeProvider.colorScheme!.background,
            themeProvider.colorScheme!.background.withOpacity(0),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: widget.icon.isNotEmpty,
            child: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                widget.icon,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  widget.isSelectedItem ? themeProvider.colorScheme!.primary : themeProvider.colorScheme!.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.icon.isNotEmpty,
            child: const SizedBox(width: 6),
          ),
          Text(
            widget.label,
            style: widget.textStyle.copyWith(
              color: widget.isSelectedItem ? themeProvider.colorScheme?.primary : themeProvider.colorScheme?.secondary,
            ),
          ),
          Visibility(
            visible: widget.icon.isNotEmpty,
            child: const Spacer(),
          ),
          Visibility(
            visible: widget.icon.isNotEmpty,
            child: RotationTransition(
              turns: widget.animation == null ? const AlwaysStoppedAnimation(0.0) : widget.animation!,
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: themeProvider.colorScheme?.secondary,
              ),
            ),
          ),
          Visibility(visible: widget.icon.isNotEmpty, child: const SizedBox(width: 6)),
        ],
      ),
    );
  }
}
