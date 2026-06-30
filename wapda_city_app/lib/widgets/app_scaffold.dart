import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/app_screen.dart';
import '../state/app_state.dart';
import 'bottom_nav_bar.dart';

/// Screens whose header sits on a dark/gradient background, so the OS
/// status bar icons should render light — mirrors `gradScreens` in the
/// prototype's `statusColor` logic.
const Set<AppScreen> kGradScreens = {
  AppScreen.splash,
  AppScreen.welcome,
  AppScreen.sos,
  AppScreen.home,
  AppScreen.paySuccess,
  AppScreen.profile,
  AppScreen.eventDetail,
  AppScreen.mcDashboard,
  AppScreen.empDashboard,
  AppScreen.listingDetail,
};

/// Wraps every screen body: applies the themed background, status-bar
/// brightness, system-back handling (mirrors `back()`), and the bottom nav
/// when the current screen is a nav root.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final bool scrollable;
  final Color? backgroundColor;

  /// When true, content bleeds under the status bar (hero/gradient header
  /// screens) and is responsible for its own top inset via [topInset].
  final bool bleedTop;

  const AppScaffold({super.key, required this.body, this.scrollable = true, this.backgroundColor, this.bleedTop = false});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final light = kGradScreens.contains(s.screen);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        s.back();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: backgroundColor ?? c.bg,
          body: SafeArea(
            top: !bleedTop,
            bottom: false,
            child: scrollable ? SingleChildScrollView(child: body) : body,
          ),
          bottomNavigationBar: s.showNav ? const AppBottomNav() : null,
        ),
      ),
    );
  }
}

/// Top inset to use inside a [bleedTop] screen so content clears the status bar.
double topInset(BuildContext context) => MediaQuery.of(context).padding.top;

