import 'package:flutter/material.dart';
import 'package:selfview_app/pages/widget/custom_appbar.dart';

class TrendPage extends StatelessWidget {
  const TrendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120), // снизу запас под navbar
      itemCount: 40,
      itemBuilder: (context, i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Trend item ${i + 1}',
            style: const TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}



