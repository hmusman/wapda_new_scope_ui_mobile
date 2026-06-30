import 'package:flutter/material.dart';

/// Static colour tokens mirrored 1:1 from the design prototype's
/// `.theme-light` / `.theme-dark` CSS custom properties.
class AppColors {
  final Color bg;
  final Color surface;
  final Color surface2;
  final Color primary;
  final Color primaryDark;
  final Color primaryTint;
  final Color maroon;
  final Color success;
  final Color successTint;
  final Color amber;
  final Color amberTint;
  final Color danger;
  final Color dangerTint;
  final Color ink;
  final Color mid;
  final Color light;
  final Color border;
  final Color gold;
  final Color shadow;
  final Color navIdle;
  final Color slate;

  const AppColors({
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.primary,
    required this.primaryDark,
    required this.primaryTint,
    required this.maroon,
    required this.success,
    required this.successTint,
    required this.amber,
    required this.amberTint,
    required this.danger,
    required this.dangerTint,
    required this.ink,
    required this.mid,
    required this.light,
    required this.border,
    required this.gold,
    required this.shadow,
    required this.navIdle,
    required this.slate,
  });

  static const light = AppColors(
    bg: Color(0xFFF2EDE4),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFFBF7F0),
    primary: Color(0xFFC0512B),
    primaryDark: Color(0xFF9A3D1E),
    primaryTint: Color(0xFFF6E7DE),
    maroon: Color(0xFF5E2419),
    success: Color(0xFF5C8A6A),
    successTint: Color(0xFFE6EFE7),
    amber: Color(0xFFB7822A),
    amberTint: Color(0xFFF5EAD3),
    danger: Color(0xFFBF3B2B),
    dangerTint: Color(0xFFF6E1DC),
    ink: Color(0xFF2A2420),
    mid: Color(0xFF6E6155),
    light: Color(0xFFA99B8B),
    border: Color(0xFFE8DFD0),
    gold: Color(0xFFA8823C),
    shadow: Color(0x14462D19),
    navIdle: Color(0xFFB2A493),
    slate: Color(0xFF4A7C8C),
  );

  static const dark = AppColors(
    bg: Color(0xFF19150F),
    surface: Color(0xFF241E17),
    surface2: Color(0xFF2C261D),
    primary: Color(0xFFD97757),
    primaryDark: Color(0xFFC0512B),
    primaryTint: Color(0xFF3A2920),
    maroon: Color(0xFF3A1A12),
    success: Color(0xFF74AC8A),
    successTint: Color(0xFF22302A),
    amber: Color(0xFFD6A24C),
    amberTint: Color(0xFF332817),
    danger: Color(0xFFE16B57),
    dangerTint: Color(0xFF3A201B),
    ink: Color(0xFFF1E9DD),
    mid: Color(0xFFB4A795),
    light: Color(0xFF7E7160),
    border: Color(0xFF393125),
    gold: Color(0xFFCBA660),
    shadow: Color(0x73000000),
    navIdle: Color(0xFF7E7160),
    slate: Color(0xFF6FA3B4),
  );
}

/// Per-role accent colours layered on top of the light/dark base tokens —
/// mirrors `.role-member`, `.role-tenant`, `.role-employee`, `.role-mc`.
class RoleAccent {
  final Color accent;
  final Color accent2;
  final List<Color> gradient;

  const RoleAccent({required this.accent, required this.accent2, required this.gradient});

  static const memberFamily = RoleAccent(
    accent: Color(0xFFC0512B),
    accent2: Color(0xFF9A3D1E),
    gradient: [Color(0xFF5E2419), Color(0xFFA8431F), Color(0xFFC76A31)],
  );

  static const tenant = RoleAccent(
    accent: Color(0xFF5C8A6A),
    accent2: Color(0xFF3F6B50),
    gradient: [Color(0xFF21402F), Color(0xFF3F6B50), Color(0xFF5C8A6A)],
  );

  static const employee = RoleAccent(
    accent: Color(0xFF4A7C8C),
    accent2: Color(0xFF356070),
    gradient: [Color(0xFF1C3A44), Color(0xFF356070), Color(0xFF4A7C8C)],
  );

  static const mc = RoleAccent(
    accent: Color(0xFFA8823C),
    accent2: Color(0xFF7A551A),
    gradient: [Color(0xFF3A2A0C), Color(0xFF7A551A), Color(0xFFB58E45)],
  );
}
