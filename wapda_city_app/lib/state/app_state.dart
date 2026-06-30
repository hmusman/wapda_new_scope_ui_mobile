import 'package:flutter/material.dart';
import '../models/app_screen.dart';
import '../models/user_role.dart';
import '../theme/app_colors.dart';

enum BillTab { pending, paid, all }

enum DirTab { local, service }

enum ComFilter { top, help, announcement, entertainment, recent }

enum ComTab { social, market }

enum MktFilter { all, furniture, electronics, mechanical, home }

/// Central app state — a faithful Flutter port of the prototype's
/// `Component.state` + handler methods (nav/back/tabNav/jump/pickRole/
/// setRole/enterApp/toggleTheme/setBillTab/...).
class AppState extends ChangeNotifier {
  AppScreen screen = AppScreen.splash;
  AppTab tab = AppTab.home;
  bool dark = false;
  UserRole role = UserRole.member;
  UserRole regRole = UserRole.member;
  final List<AppScreen> stack = [];

  BillTab billTab = BillTab.pending;
  DirTab dirTab = DirTab.local;
  ComFilter comFilter = ComFilter.top;
  ComTab comTab = ComTab.social;
  MktFilter mktFilter = MktFilter.all;

  static AppScreen homeFor(UserRole r) {
    if (r == UserRole.mc) return AppScreen.mcDashboard;
    if (r == UserRole.employee) return AppScreen.empDashboard;
    return AppScreen.home;
  }

  static const Set<AppScreen> _roots = {
    AppScreen.home,
    AppScreen.media,
    AppScreen.sos,
    AppScreen.community,
    AppScreen.polls,
  };

  static AppTab? _tabForScreen(AppScreen s) {
    switch (s) {
      case AppScreen.home:
        return AppTab.home;
      case AppScreen.media:
        return AppTab.media;
      case AppScreen.sos:
        return AppTab.sos;
      case AppScreen.community:
        return AppTab.community;
      case AppScreen.polls:
        return AppTab.polls;
      default:
        return null;
    }
  }

  bool get showNav => kRootScreens.contains(screen);

  /// Navigate forward, pushing the current screen onto the back-stack.
  void nav(AppScreen target) {
    stack.add(screen);
    screen = target;
    final t = _tabForScreen(target);
    if (t != null) tab = t;
    notifyListeners();
  }

  /// Pop the back-stack (used by every screen's back arrow + system back).
  void back() {
    if (stack.isEmpty) {
      screen = AppScreen.welcome;
    } else {
      screen = stack.removeLast();
    }
    notifyListeners();
  }

  /// Bottom-nav tab tap.
  void tabNav(AppTab t) {
    final sc = t == AppTab.home ? homeFor(role) : _screenForTab(t);
    tab = t;
    screen = sc;
    stack.clear();
    notifyListeners();
  }

  static AppScreen _screenForTab(AppTab t) {
    switch (t) {
      case AppTab.home:
        return AppScreen.home;
      case AppTab.media:
        return AppScreen.media;
      case AppTab.sos:
        return AppScreen.sos;
      case AppTab.community:
        return AppScreen.community;
      case AppTab.polls:
        return AppScreen.polls;
    }
  }

  /// Role-picker card tap during registration.
  void pickRole(UserRole r, AppScreen target) {
    regRole = r;
    stack.add(screen);
    screen = target;
    notifyListeners();
  }

  /// Used by the in-app "Switch Role" demo screen.
  void setRole(UserRole r) {
    role = r;
    screen = homeFor(r);
    tab = AppTab.home;
    stack.clear();
    notifyListeners();
  }

  /// Finishes registration (regPending -> live app).
  void enterApp() {
    role = regRole;
    screen = homeFor(regRole);
    tab = AppTab.home;
    stack.clear();
    notifyListeners();
  }

  /// Used by the Profile screen's Logout action (mirrors the prototype's
  /// `jump('welcome')` dev-tool navigation).
  void logout() {
    stack.clear();
    screen = AppScreen.welcome;
    notifyListeners();
  }

  void splashDone() {
    if (screen == AppScreen.splash) {
      screen = AppScreen.welcome;
      stack.clear();
      notifyListeners();
    }
  }

  void toggleTheme() {
    dark = !dark;
    notifyListeners();
  }

  void setBillTab(BillTab t) {
    billTab = t;
    notifyListeners();
  }

  void setDirTab(DirTab t) {
    dirTab = t;
    notifyListeners();
  }

  void setComFilter(ComFilter f) {
    comFilter = f;
    notifyListeners();
  }

  void setComTab(ComTab t) {
    comTab = t;
    notifyListeners();
  }

  void setMktFilter(MktFilter f) {
    mktFilter = f;
    notifyListeners();
  }

  // ---- derived display values (mirrors renderVals()) ----

  AppColors get colors => dark ? AppColors.dark : AppColors.light;
  RoleAccent get accent => role.accent;

  Identity get identity => kIdentities[role]!;

  bool get isTenant => role == UserRole.tenant;

  String get greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    if (h < 21) return 'Good Evening';
    return 'Good Night';
  }

  String get regRoleLabel {
    switch (regRole) {
      case UserRole.member:
        return 'Owner';
      case UserRole.family:
        return 'Family Member';
      case UserRole.tenant:
        return 'Tenant';
      case UserRole.employee:
        return 'Employee';
      case UserRole.mc:
        return '';
    }
  }

  bool get regIsEmployee => regRole == UserRole.employee;
  bool get regIsProperty => regRole != UserRole.employee;
  bool get regIsFamily => regRole == UserRole.family;

  String get regRelayNote => (regRole == UserRole.family || regRole == UserRole.tenant)
      ? "An OTP will be sent to the owner's registered mobile. Ask the owner to share the code with you."
      : "An OTP will be sent to the mobile registered against this property.";

  String get regOtpHint => regRole == UserRole.family
      ? "Register as a family member of the property owner."
      : regRole == UserRole.tenant
          ? "Register as a tenant. The owner authorises your access."
          : "Confirm the property you own.";

  String get regOtpTarget => (regRole == UserRole.family || regRole == UserRole.tenant)
      ? "Sent to the owner's mobile +92 3xx xxxxxxx. Enter the code they share with you."
      : "Sent to +92 3xx xxxxxxx registered with this property.";
}
