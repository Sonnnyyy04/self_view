import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pages/discover/discover.dart';
import '../pages/ootd/ootd.dart';
import '../pages/trend/trend.dart';
import '../pages/try_it_on/try_it_on.dart';
import 'custom_appbar.dart';

class CustomFrostedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomFrostedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const active = Color(0xFF2D6CDF);
  static const inactive = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0), // отступы по краям
        child: ClipRRect(
          //borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              width: double.infinity,
              height: 76,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0x55FFFFFF),  // ✅ более прозрачное стекло
                //borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12), // мягче
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: _dockItem('Trends', "assets/icons/trend.svg", 0)),
                  Expanded(child: _dockItem('Discover', "assets/icons/search.svg", 1)),
                  Expanded(child: _dockItem('Try It On', "assets/icons/try.svg", 2)),
                  Expanded(child: _dockItem('OOTD', "assets/icons/ootd.svg", 3)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dockItem(String label, String asset, int i) {
    final selected = i == currentIndex;
    final c = selected ? active : inactive;

    return InkWell(
      onTap: () => onTap(i),
      //borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                height: 1,
                color: c,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  bool _navVisible = true;


  final _pages = const [
    TrendPage(),
    DiscoverPage(),
    TryItOnPage(),
    OotdPage(),
    // ClosetPage(),
  ];

  bool _onScroll(ScrollNotification n) {
    if (n is UserScrollNotification) {
      if (n.metrics.axis == Axis.vertical) {
        if (n.direction == ScrollDirection.reverse && _navVisible) {
          // скролл вниз -> скрыть
          setState(() => _navVisible = false);
        } else if (n.direction == ScrollDirection.forward && !_navVisible) {
          // скролл вверх -> показать
          setState(() => _navVisible = true);
        }
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        extendBody: true,
        //backgroundColor: Color(0xE5FFFFFF),

        body: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: IndexedStack(index: _index, children: _pages),
        ),

        bottomNavigationBar: AnimatedSlide(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
          offset: _navVisible ? Offset.zero : const Offset(0, 1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: _navVisible ? 1 : 0,
            child: IgnorePointer(
              ignoring: !_navVisible, // чтобы по скрытому не нажималось
              child: CustomFrostedBottomNavBar(
                currentIndex: _index,
                onTap: (i) => setState(() => _index = i),
              ),
            ),
          ),
        )
    );
  }
}