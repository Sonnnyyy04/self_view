import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfview_app/pages/design/images.dart';

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
              width: double.infinity,            // ✅ на всю ширину
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
                  Expanded(child: _dockItem('Trends', trend, 0)),
                  Expanded(child: _dockItem('Discover', search, 1)),
                  Expanded(child: _dockItem('Try It On', hanger, 2)),
                  Expanded(child: _dockItem('OOTD', ootd, 3)),
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
      borderRadius: BorderRadius.circular(14),
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
