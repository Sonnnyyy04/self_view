import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfview_app/pages/design/images.dart';

class TrendPage extends StatelessWidget {
  const TrendPage({super.key});

  static const _items = <TrendItem>[
    TrendItem(image: 'assets/images/1.jpeg', name: 'Frost'),
    TrendItem(image: 'assets/images/2.jpeg', name: 'Titan'),
    TrendItem(image: 'assets/images/3.jpeg', name: 'Harmony'),
    TrendItem(image: 'assets/images/4.jpeg', name: 'Luna'),
    TrendItem(image: 'assets/images/5.jpeg', name: 'Frost'),
    TrendItem(image: 'assets/images/6.jpeg', name: 'Titan'),
    TrendItem(image: 'assets/images/7.jpeg', name: 'Harmony'),
    TrendItem(image: 'assets/images/8.jpeg', name: 'Luna'),
    TrendItem(image: 'assets/images/9.jpg', name: 'Frost'),
    TrendItem(image: 'assets/images/10.jpg', name: 'Titan'),
  ];

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      crossAxisCount: 2,
      mainAxisSpacing: 7,   // было слишком много
      crossAxisSpacing: 5,  // было слишком много
      itemCount: _items.length,
      itemBuilder: (context, i) => TrendCard(item: _items[i]),
    );
  }
}
class TrendItem {
  final String image;
  final String name;

  const TrendItem({required this.image, required this.name});
}

class TrendCard extends StatelessWidget {
  final TrendItem item;
  const TrendCard({super.key, required this.item});

  static const brand = Color(0xFFC49A5A);
  static const nameColor = Color(0xFF46678E);

  @override
  Widget build(BuildContext context) {
    const r = 5.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Картинка — только верхние скругления (низ будет ровный, т.к. дальше идет плашка)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(r),
                topRight: Radius.circular(r),
              ),
              child: Image.asset(
                item.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Нижняя плашка (внутри того же блока)
            Container(
              height: 44, // как на скрине примерно
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xFFF7F7F7), // легкий серый как в DLOOK
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0xFFE6E0F8),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        color: nameColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ootd,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(brand, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Try',
                        style: TextStyle(
                          fontSize: 15,
                          color: brand,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



