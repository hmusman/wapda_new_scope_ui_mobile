import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../models/user_role.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final id = s.identity;

    return AppScaffold(
      bleedTop: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(22, topInset(context) + 14, 22, 50),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackCircle(onTap: () => s.back()),
                    GestureDetector(
                      onTap: () => s.nav(AppScreen.settings),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.settings_outlined, color: Colors.white, size: 19),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                InitialsAvatar(initials: id.initials, size: 72),
                const SizedBox(height: 12),
                Text(id.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 3),
                Text(id.role, style: const TextStyle(fontSize: 12.5, color: Colors.white70)),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -28),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: c.shadow, blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Row(
                  children: [
                    Expanded(child: _stat(c, mockBills.where((b) => !b.paid).length.toString(), 'Bills Due')),
                    _divider(c),
                    Expanded(child: _stat(c, mockComplaints.length.toString(), 'Complaints')),
                    _divider(c),
                    Expanded(child: _stat(c, mockNotices.length.toString(), 'Notices')),
                    _divider(c),
                    Expanded(child: _stat(c, mockVisitors.length.toString(), 'Visitors')),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PERSONAL DETAILS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: c.light, letterSpacing: 0.6)),
                  const SizedBox(height: 9),
                  AppCard(
                    child: Column(
                      children: [
                        _detailRow(c, Icons.home_outlined, 'Property', id.prop),
                        Divider(height: 22, color: c.border),
                        _detailRow(c, Icons.phone_outlined, 'Phone', '+92 300 1234567'),
                        Divider(height: 22, color: c.border),
                        _detailRow(c, Icons.email_outlined, 'Email', 'ahsan.raza@example.com'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _menuRow(context, c, Icons.swap_horiz, 'Switch Panel', () => s.nav(AppScreen.switchRole)),
                  _menuRow(context, c, Icons.notifications_outlined, 'Notifications', () => s.nav(AppScreen.notifications)),
                  _menuRow(context, c, Icons.settings_outlined, 'Settings', () => s.nav(AppScreen.settings)),
                  _menuRow(context, c, Icons.logout, 'Logout', () => s.logout(), danger: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(AppColors c, String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: c.ink)),
        const SizedBox(height: 3),
        Text(label, style: TextStyle(fontSize: 9.5, color: c.light)),
      ],
    );
  }

  Widget _divider(AppColors c) => Container(width: 1, height: 28, color: c.border);

  Widget _detailRow(AppColors c, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 17, color: c.light),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 10.5, color: c.light)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuRow(BuildContext context, AppColors c, IconData icon, String label, VoidCallback onTap, {bool danger = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: c.surface,
            border: Border.all(color: c.border, width: 1.4),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, size: 19, color: danger ? c.danger : c.mid),
              const SizedBox(width: 13),
              Expanded(child: Text(label, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: danger ? c.danger : c.ink))),
              if (!danger) Icon(Icons.arrow_forward_ios, size: 13, color: c.light),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'Settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PREFERENCES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: c.light, letterSpacing: 0.6)),
          const SizedBox(height: 9),
          AppCard(
            child: Column(
              children: [
                _toggleRow(c, s, 'Push Notifications', true, null),
                Divider(height: 22, color: c.border),
                _toggleRow(c, s, 'SOS Alerts', true, null, enabled: false),
                Divider(height: 22, color: c.border),
                _navRow(c, 'Language', 'English'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text('APPEARANCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: c.light, letterSpacing: 0.6)),
          const SizedBox(height: 9),
          AppCard(
            child: _toggleRow(c, s, 'Dark Mode', s.dark, () => s.toggleTheme()),
          ),
          const SizedBox(height: 18),
          Text('SUPPORT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: c.light, letterSpacing: 0.6)),
          const SizedBox(height: 9),
          AppCard(
            child: Column(
              children: [
                _navRow(c, 'Help & Support', ''),
                Divider(height: 22, color: c.border),
                _navRow(c, 'About App', 'v2.0.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleRow(AppColors c, AppState s, String label, bool value, VoidCallback? onTap, {bool enabled = true}) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontSize: 13.5, color: c.ink, fontWeight: FontWeight.w600))),
          Switch(
            value: value,
            onChanged: enabled ? (_) => onTap?.call() : null,
            activeColor: s.accent.accent,
          ),
        ],
      ),
    );
  }

  Widget _navRow(AppColors c, String label, String value) {
    return Row(
      children: [
        Expanded(child: Text(label, style: TextStyle(fontSize: 13.5, color: c.ink, fontWeight: FontWeight.w600))),
        Text(value, style: TextStyle(fontSize: 12.5, color: c.light)),
        const SizedBox(width: 6),
        Icon(Icons.arrow_forward_ios, size: 12, color: c.light),
      ],
    );
  }
}

class SwitchRoleScreen extends StatelessWidget {
  const SwitchRoleScreen({super.key});

  static const _roles = [UserRole.member, UserRole.employee, UserRole.mc];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return GestureDetector(
      onTap: () => s.back(),
      child: Material(
        color: Colors.black.withOpacity(0.45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(width: 38, height: 4, decoration: BoxDecoration(color: c.border, borderRadius: BorderRadius.circular(3))),
                    ),
                    const SizedBox(height: 18),
                    Text('Switch Panel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: c.ink)),
                    const SizedBox(height: 4),
                    Text('Demo only — switch between role views.', style: TextStyle(fontSize: 12, color: c.light)),
                    const SizedBox(height: 16),
                    ..._roles.map((r) {
                      final active = s.role == r;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => s.setRole(r),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: active ? r.accent.accent.withOpacity(0.1) : c.surface2,
                              border: Border.all(color: active ? r.accent.accent : c.border, width: active ? 1.6 : 1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                InitialsAvatar(initials: kIdentities[r]!.initials, size: 38, bg: r.accent.accent.withOpacity(0.18), fg: r.accent.accent),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(r.label, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                                      Text(kIdentities[r]!.name, style: TextStyle(fontSize: 11.5, color: c.light)),
                                    ],
                                  ),
                                ),
                                if (active) Icon(Icons.check_circle, color: r.accent.accent, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  IconData _iconFor(String type) {
    switch (type) {
      case 'bill':
        return Icons.receipt_long_outlined;
      case 'complaint':
        return Icons.report_problem_outlined;
      case 'notice':
        return Icons.campaign_outlined;
      case 'visitor':
        return Icons.person_outline;
      default:
        return Icons.notifications_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final today = mockNotifications.where((n) => n.time.contains('h ago')).toList();
    final yesterday = mockNotifications.where((n) => !n.time.contains('h ago')).toList();

    return SubScreen(
      title: 'Notifications',
      trailing: GestureDetector(
        onTap: () {},
        child: Text('Mark all read', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: s.accent.accent)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (today.isNotEmpty) ...[
            Text('TODAY', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: c.light, letterSpacing: 0.6)),
            const SizedBox(height: 9),
            ...today.map((n) => _notifTile(c, s, n)),
            const SizedBox(height: 14),
          ],
          if (yesterday.isNotEmpty) ...[
            Text('YESTERDAY', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: c.light, letterSpacing: 0.6)),
            const SizedBox(height: 9),
            ...yesterday.map((n) => _notifTile(c, s, n)),
          ],
        ],
      ),
    );
  }

  Widget _notifTile(AppColors c, AppState s, AppNotification n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: n.read ? c.surface : c.primaryTint,
          border: Border(left: BorderSide(color: n.read ? Colors.transparent : s.accent.accent, width: 3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: c.surface2, shape: BoxShape.circle),
              child: Icon(_iconFor(n.type), size: 17, color: c.mid),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(n.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                  const SizedBox(height: 3),
                  Text(n.body, style: TextStyle(fontSize: 11.5, color: c.mid, height: 1.4)),
                  const SizedBox(height: 4),
                  Text(n.time, style: TextStyle(fontSize: 10.5, color: c.light)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
