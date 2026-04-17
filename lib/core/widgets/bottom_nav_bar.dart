import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_images.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavBar({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final currentIndex = navigationShell.currentIndex;

    return DecoratedBox(
      decoration: BoxDecoration(color: colorScheme.surface),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: bottomInset > 0 ? 0 : 8),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSurfaceVariant,
          selectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
          unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          iconSize: 30,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImages.exploreNavButton,
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: '',
            ),
          ],
          currentIndex: currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
