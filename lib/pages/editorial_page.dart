import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:odiya_news_app/constants/app_textstyles.dart';

class EditorialPage extends StatelessWidget {
  const EditorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.clock, size: 150),
            Text('Coming Soon!', style: AppTextStyles.displayLarge),
          ],
        ),
      ),
    );
  }
}
