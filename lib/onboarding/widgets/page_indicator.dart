import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int length;
  final int currentPage;
  const PageIndicator({super.key, required this.length, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => _buildPageIndicator(index, context),
        ),
      ),
    );
    
  }
   Widget _buildPageIndicator(int index, BuildContext context) {
    final isActive = currentPage == index;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  
}