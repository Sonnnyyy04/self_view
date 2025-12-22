import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfview_app/src/app.dart';
import 'package:selfview_app/src/pages/design/images.dart';
import 'package:selfview_app/src/res/res.dart';
import 'package:url_launcher/url_launcher.dart';

class TrendPage extends StatefulWidget {
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
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  int _selectedTab = 0;
  void _onTabSelected(int index){
    setState(() {
      _selectedTab = index;
    });
  }

  void _openYoutube(int index) async{
    setState(() {
      _selectedTab = index;
    });
    final Uri url = Uri.parse('https://www.youtube.com/results?search_query=dress');
    if (await canLaunchUrl(url)){
      await launchUrl(url);
    }else{
      throw 'Could not open the $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTab(context,'For You', null, _selectedTab == 0,  () => _onTabSelected(0)),  // Первая вкладка с активным состоянием
                _buildTab(context,'Pinterest', CustomSvg.pinterest, _selectedTab == 1, () => _onTabSelected(1),),
                _buildTab(context,'Instagram', CustomSvg.instagram, _selectedTab == 2, () => _onTabSelected(2),),
                _buildTab(context,'Youtube', CustomSvg.youtube, _selectedTab == 3, () => _openYoutube(3),),
              ],
            ),
          ),
        ),
        Expanded(
          child: MasonryGridView.count(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            crossAxisCount: 2,
            mainAxisSpacing: 7,
            // было слишком много
            crossAxisSpacing: 5,
            // было слишком много
            itemCount: TrendPage._items.length,
            itemBuilder: (context, i) => TrendCard(item: TrendPage._items[i]),
          ),
        ),
      ]
    );
  }
}

Widget _buildTab(BuildContext context, String title, String? assetName, bool isSelected, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (assetName != null)...[
            SvgPicture.asset(
              assetName,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 18,
              color: isSelected ? Color(0xFF2D6CDF) : Colors.grey, // Цвет текста
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Полужирный текст для активной вкладки
            ),
          ),
        ],
      ),
    ),
  );
}

class TrendItem {
  final String image;
  final String name;

  const TrendItem({required this.image, required this.name});
}

class TrendCard extends StatelessWidget {
  final TrendItem item;

  const TrendCard({super.key, required this.item});

  static const ocean = Color(0xFF2D6CDF);
  static const nameColor = Color(0xFF6C6E75);

  @override
  Widget build(BuildContext context) {
    const r = 5.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
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
              color: const Color(0xFFFFFFFF), // легкий серый как в DLOOK
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        color: nameColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ootd,
                        colorFilter: ColorFilter.mode(ocean, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          // Ваш обработчик нажатия
                        },
                        child: Text(
                          'Try',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14,
                            color: ocean,
                            fontWeight: FontWeight.w700,
                          ),
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
