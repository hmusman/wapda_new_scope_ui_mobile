import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_screen.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final s = context.watch<AppState>();
    final accent = s.accent;

    return AppScaffold(
      bleedTop: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(22, topInset(context) + 14, 22, 76),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11)),
                            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 11),
                          const Text('WAPDA City', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => s.nav(AppScreen.notifications),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                const Icon(Icons.notifications_outlined, color: Colors.white, size: 23),
                                Positioned(
                                  top: -3,
                                  right: -3,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: c.danger, shape: BoxShape.circle),
                                    child: const Text('3', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          GestureDetector(
                            onTap: () => s.nav(AppScreen.profile),
                            child: InitialsAvatar(initials: s.identity.initials, size: 36),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text('${s.greeting},', style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w300, color: Colors.white70)),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(s.identity.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white)),
                      const SizedBox(width: 8),
                      const Icon(Icons.verified, size: 18, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text('${s.identity.prop} · ${s.identity.role}', style: const TextStyle(fontSize: 12.5, color: Colors.white70)),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: s.isTenant ? _tenantNotice(c) : _chargeCard(context, c, s),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: c.ink)),
                    const SizedBox(height: 14),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 13,
                      crossAxisSpacing: 13,
                      childAspectRatio: 0.95,
                      children: [
                        _tile(context, c, 'Charges', Icons.receipt_long_outlined, c.primaryTint, c.primary, AppScreen.bills),
                        _tile(context, c, 'Complaints', Icons.report_problem_outlined, c.amberTint, c.amber, AppScreen.complaints, dot: true),
                        _tile(context, c, 'Notices', Icons.campaign_outlined, c.successTint, c.success, AppScreen.notices, badge: '2'),
                        _tile(context, c, 'Directory', Icons.contacts_outlined, c.primaryTint, c.primary, AppScreen.directory),
                        _tile(context, c, 'Visitors', Icons.group_add_outlined, c.amberTint, c.amber, AppScreen.visitors),
                        _tile(context, c, 'Events', Icons.event_outlined, c.successTint, c.success, AppScreen.events),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent Activity', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: c.ink)),
                        GestureDetector(
                          onTap: () => s.nav(AppScreen.notifications),
                          child: Text('See all', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: accent.accent)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: c.surface,
                        border: Border.all(color: c.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _activityRow(context, c, Icons.history_toggle_off, c.amberTint, c.amber, 'Complaint #1042 in progress', 'Water supply · yesterday',
                              AppScreen.complaintDetail, pill: 'ACTIVE', pillColor: c.amber, border: true),
                          _activityRow(context, c, Icons.event_outlined, c.primaryTint, c.primary, 'Eid Milad event · Sat 6 PM', '128 going', AppScreen.events,
                              border: true),
                          _activityRow(context, c, Icons.campaign_outlined, c.successTint, c.success, 'New notice: Water tank cleaning', '3 days ago',
                              AppScreen.notices),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chargeCard(BuildContext context, AppColors c, AppState s) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: c.maroon, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current Service Charge', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  const SizedBox(height: 5),
                  const Text('PKR 2,500', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 3),
                  const Text('Due 30 June 2026 · June billing', style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
              StatusPill(text: 'PENDING', color: const Color(0xFF92600F), tint: c.amberTint),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => s.nav(AppScreen.payMethod),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: c.success, borderRadius: BorderRadius.circular(12)),
                    child: const Text('PAY NOW', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(width: 11),
              GestureDetector(
                onTap: () => s.nav(AppScreen.bills),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.16), borderRadius: BorderRadius.circular(12)),
                  child: const Text('History', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tenantNotice(AppColors c) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(13)),
            child: Icon(Icons.account_balance_wallet_outlined, color: c.light),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Service charges', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.ink)),
                const SizedBox(height: 2),
                Text("Handled by the property owner. Tenants don't pay or view billing.", style: TextStyle(fontSize: 12, color: c.mid)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, AppColors c, String label, IconData icon, Color tint, Color fg, AppScreen target, {bool dot = false, String? badge}) {
    final s = context.read<AppState>();
    return GestureDetector(
      onTap: () => s.nav(target),
      child: Container(
        decoration: BoxDecoration(
          color: c.surface,
          border: Border.all(color: c.border),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: c.shadow, blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(15)),
                    child: Icon(icon, color: fg, size: 24),
                  ),
                  const SizedBox(height: 9),
                  Text(label, style: TextStyle(fontSize: 12, color: c.ink, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            if (dot)
              Positioned(
                top: 10,
                right: 16,
                child: Container(width: 9, height: 9, decoration: BoxDecoration(color: c.danger, shape: BoxShape.circle, border: Border.all(color: c.surface, width: 1.5))),
              ),
            if (badge != null)
              Positioned(
                top: 7,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: c.danger, borderRadius: BorderRadius.circular(9), border: Border.all(color: c.surface, width: 1.5)),
                  child: Text(badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _activityRow(BuildContext context, AppColors c, IconData icon, Color tint, Color fg, String title, String subtitle, AppScreen target,
      {String? pill, Color? pillColor, bool border = false}) {
    final s = context.read<AppState>();
    return GestureDetector(
      onTap: () => s.nav(target),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        decoration: BoxDecoration(border: border ? Border(bottom: BorderSide(color: c.border)) : null),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(11)),
              child: Icon(icon, size: 20, color: fg),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 11.5, color: c.light)),
                ],
              ),
            ),
            if (pill != null) StatusPill(text: pill, color: pillColor!, tint: pillColor.withOpacity(0.15)),
          ],
        ),
      ),
    );
  }
}
