import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfview_app/src/pages/discover/store.dart';
import 'package:selfview_app/src/pages/design/images.dart';
import 'package:selfview_app/src/widgets/custom_appbar.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: _SearchBar(
              hintText: 'Search outfits, brand, or link',
              onChanged: (_){},
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            children: [
              _BrandCircle(label: 'Adidas', child: SvgPicture.asset(adidas)),
              _BrandCircle(label: 'ASOS', child:  SvgPicture.asset(asos)),
              _BrandCircle(label: 'LOUIS V...', child: SvgPicture.asset(louis_vuitton)),
              _BrandCircle(label: 'Miu Miu', child:  SvgPicture.asset(miu_miu)),
              _BrandCircle(label: 'Nike', child:  SvgPicture.asset(nike)),
              _BrandCircle(label: 'NewBalance', child:  SvgPicture.asset(new_balance)),
              _BrandCircle(label: 'Hollister', child:  SvgPicture.asset(hollister)),
              _BrandCircle(
                label: 'More',
                child: const Icon(Icons.more_horiz),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const StoresPage()),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const _SearchBar({
    required this.hintText,
    required this.onChanged,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        )
      ),
    );
  }
}

class _BrandCircle extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback? onTap;
  const _BrandCircle({
    required this.label,
    required this.child,
    this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      height: 56,
      width: 56,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: const TextStyle(fontWeight: FontWeight.w700),
        child: child,
      ),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          circle,
          const SizedBox(height: 4,),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}


