import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_screen.dart';
import '../state/app_state.dart';

/// Bottom navigation bar — fixed order Polls · Media · SOS · Community · Home,
/// with a raised circular SOS button in the centre.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final accent = s.accent.accent;

    Color colorFor(AppTab t) => s.tab == t ? accent : c.navIdle;
    Color homeColor() {
      final onHomeSection = s.screen == AppScreen.home ||
          s.screen == AppScreen.mcDashboard ||
          s.screen == AppScreen.empDashboard;
      return onHomeSection ? accent : c.navIdle;
    }

    Widget tabItem({required AppTab tab, required IconData icon, required String label, required Color color}) {
      return Expanded(
        child: InkWell(
          onTap: () => s.tabNav(tab),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 23, color: color),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: color)),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 84,
      padding: const EdgeInsets.only(top: 11),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.border)),
        boxShadow: [BoxShadow(color: c.shadow, blurRadius: 20, offset: const Offset(0, -6))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tabItem(tab: AppTab.polls, icon: Icons.bar_chart_rounded, label: 'Polls', color: colorFor(AppTab.polls)),
          tabItem(tab: AppTab.media, icon: Icons.photo_camera_back_outlined, label: 'Media', color: colorFor(AppTab.media)),
          Expanded(
            child: InkWell(
              onTap: () => s.tabNav(AppTab.sos),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: -26),
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: c.danger,
                      shape: BoxShape.circle,
                      border: Border.all(color: c.surface, width: 4),
                      boxShadow: [BoxShadow(color: c.danger.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 8))],
                    ),
                    child: const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 26),
                  ),
                  const SizedBox(height: 3),
                  Text('SOS', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: c.danger)),
                ],
              ),
            ),
          ),
          tabItem(tab: AppTab.community, icon: Icons.groups_outlined, label: 'Community', color: colorFor(AppTab.community)),
          tabItem(tab: AppTab.home, icon: Icons.home_outlined, label: 'Home', color: homeColor()),
        ],
      ),
    );
  }
}
