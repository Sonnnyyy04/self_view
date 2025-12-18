import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:selfview_app/pages/discover/discover.dart';
import 'package:selfview_app/pages/ootd/ootd.dart';
import 'package:selfview_app/pages/trend/trend.dart';
import 'package:selfview_app/pages/try_it_on/try_it_on.dart';
import 'package:selfview_app/pages/widget/custom_appbar.dart';
import 'package:selfview_app/pages/widget/custom_frostedBottomNavBar.dart';

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
      if (n.direction == ScrollDirection.reverse && _navVisible) {
        // скролл вниз -> скрыть
        setState(() => _navVisible = false);
      } else if (n.direction == ScrollDirection.forward && !_navVisible) {
        // скролл вверх -> показать
        setState(() => _navVisible = true);
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,

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
