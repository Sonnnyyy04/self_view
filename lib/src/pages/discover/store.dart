import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  static const double _itemExtent = 56;

  final _controller = ScrollController();
  final _searchCtrl = TextEditingController();

  final List<String> _all = [
    'A.P.C.',
    'Acne Studios',
    'ADANOLA',
    'Adidas',
    'adidas Golf',
    'Agent Provocateur',
    'AKIRA',
    'Alexander McQueen',
    'Alice Balas',
    'Alo Yoga',
    'ASOS',
    'Balenciaga',
    'Bottega Veneta',
    'Chanel',
    'Dior',
    'Hollister',
    'Lululemon',
    'Louis Vuitton',
    'Miu Miu',
    'Reformation',
    'Zara',
  ]..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

  String _q = '';
  String _currentLetter = '';

  List<String> get _filtered {
    if (_q.trim().isEmpty) return _all;
    final q = _q.toLowerCase();
    return _all.where((s) => s.toLowerCase().contains(q)).toList();
  }

  Map<String, int> get _letterToIndex {
    final map = <String, int>{};
    for (int i = 0; i < _filtered.length; i++) {
      final letter = _firstLetter(_filtered[i]);
      map.putIfAbsent(letter, () => i);
    }
    return map;
  }

  Set<String> _favorites = {}; // Для хранения избранных брендов

  static String _firstLetter(String s) {
    final t = s.trim();
    if (t.isEmpty) return '#';
    final c = t[0].toUpperCase();
    final isAZ = RegExp(r'[A-Z]').hasMatch(c);
    return isAZ ? c : '#';
  }

  void _jumpToLetter(String letter) {
    setState(() {
      _currentLetter = letter; // Обновляем текущую выбранную букву
    });
    final idx = _letterToIndex[letter];
    if (idx == null) return;
    _controller.animateTo(
      idx * _itemExtent,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
    HapticFeedback.selectionClick();
  }

  void _toggleFavorite(String brand) {
    setState(() {
      if (_favorites.contains(brand)) {
        _favorites.remove(brand);
      } else {
        _favorites.add(brand);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final letters = <String>[
      for (int i = 0; i < 26; i++) String.fromCharCode('A'.codeUnitAt(0) + i),
      '#',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stores'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _q = v),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.04),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  itemExtent: _itemExtent,
                  itemCount: _filtered.length,
                  itemBuilder: (context, i) {
                    final name = _filtered[i];
                    final isFavorite = _favorites.contains(name);
                    return GestureDetector(
                      onTap: () {
                        // Открыть страницу с деталями бренда
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BrandDetailPage(brand: name),
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 60), // Добавляем отступ слева
                        title: Text(
                          name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: GestureDetector(
                          onTap: () => _toggleFavorite(name),
                          child: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: isFavorite ? Colors.yellow : Colors.black.withOpacity(0.35),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: 6,
            top: 86,
            bottom: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: letters.map((l) {
                final enabled = _letterToIndex.containsKey(l);
                return GestureDetector(
                  onTap: enabled ? () => _jumpToLetter(l) : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      l,
                      style: TextStyle(
                        fontSize: 14,
                        color: l == _currentLetter
                            ? Colors.blue // Выделение текущей буквы
                            : Colors.black, // Все буквы черные
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Страница с деталями бренда
class BrandDetailPage extends StatelessWidget {
  final String brand;

  const BrandDetailPage({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brand),
      ),
      body: Center(
        child: Text('Details for $brand'),
      ),
    );
  }
}
