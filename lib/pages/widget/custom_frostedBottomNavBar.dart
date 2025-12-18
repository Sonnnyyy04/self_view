import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:selfview_app/pages/design/images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFrostedBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged <int> onTap;
  const CustomFrostedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomFrostedBottomNavBar> createState() => _CustomFrostedBottomNavBarState();
}

class _CustomFrostedBottomNavBarState extends State<CustomFrostedBottomNavBar> {
  @override
  Widget build(BuildContext context) {

    const active = Color(0xFF2D6CDF);
    const inactive = Color(0xFF9AA3AF);
    Widget svgItems(String asset, bool selected){
      final c = selected ? active : inactive;
      return SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
      );
    }
    const bg = Color(0xFFF6F8FC);



    return SafeArea(
      top: false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: CurvedNavigationBar(
            index: widget.currentIndex,
            backgroundColor: Colors.transparent,
            color: Colors.white.withValues(alpha: 0.1),
            buttonBackgroundColor: Colors.white.withValues(alpha: 0.7),// цвет круглой кнопки
            height: 64,
            animationDuration: const Duration(milliseconds: 260),
            items: [
              svgItems(trend, widget.currentIndex == 0),
              svgItems(search, widget.currentIndex == 1),
              svgItems(hanger, widget.currentIndex == 2),
              svgItems(ootd, widget.currentIndex == 3),
            ],
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
