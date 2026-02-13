import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:odiya_news_app/constants/app_images.dart';

class IndexPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const IndexPage({super.key, required this.navigationShell});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        selectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 24,
        items: [
          BottomNavigationBarItem(icon: Icon(LucideIcons.house), label: ''),
          BottomNavigationBarItem(icon: Icon(LucideIcons.newspaper), label: ''),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.exploreNavButton,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.squarePlay),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.circleUser),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
