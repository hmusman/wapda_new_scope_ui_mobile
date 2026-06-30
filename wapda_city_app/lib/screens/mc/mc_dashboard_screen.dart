import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class McDashboardScreen extends StatelessWidget {
  const McDashboardScreen({super.key});

  static const _manage = [
    (icon: Icons.campaign_outlined, label: 'Notices', screen: AppScreen.notices),
    (icon: Icons.event_outlined, label: 'Events', screen: AppScreen.events),
    (icon: Icons.poll_outlined, label: 'Polls', screen: AppScreen.polls),
    (icon: Icons.receipt_long_outlined, label: 'Bills', screen: AppScreen.bills),
    (icon: Icons.report_problem_outlined, label: 'Complaints', screen: AppScreen.complaints),
    (icon: Icons.badge_outlined, label: 'Visitors', screen: AppScreen.visitors),
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final id = s.identity;
    final pending = mockComplaints.where((x) => x.status != 'Resolved').length;

    return AppScaffold(
      bleedTop: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(22, topInset(context) + 14, 22, 26),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
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
                          const Text('MC Admin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => s.nav(AppScreen.profile),
                        child: InitialsAvatar(initials: id.initials, size: 38),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text('${s.greeting}, ${id.name.split(' ').first}', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 3),
                  const Text('Management Committee · WAPDA City', style: TextStyle(fontSize: 12.5, color: Colors.white70)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: _stat(c, mockComplaints.length.toString(), 'Total Complaints')),
                      const SizedBox(width: 10),
                      Expanded(child: _stat(c, mockNotices.length.toString(), 'Active Notices')),
                      const SizedBox(width: 10),
                      Expanded(child: _stat(c, mockPolls.where((p) => !p.closed).length.toString(), 'Open Polls')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: c.dangerTint, borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        Icon(Icons.priority_high, color: c.danger, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('Pending Approvals', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.danger)),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: c.danger, shape: BoxShape.circle),
                          child: const Text('9', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Manage', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.6,
                    children: _manage.map((m) {
                      return GestureDetector(
                        onTap: () => s.nav(m.screen),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: c.surface,
                            border: Border.all(color: c.border, width: 1.4),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(m.icon, color: s.accent.accent, size: 22),
                              const Spacer(),
                              Text(m.label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                            const SizedBox(width: 7),
                            const Text('AI INSIGHT · Community Mood', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Colors.white70, letterSpacing: 0.4)),
                          ],
                        ),
                        const SizedBox(height: 9),
                        const Text(
                          'Sentiment is positive this week — most discussion is around the upcoming Family Mela. Streetlight complaints in Block C are trending up.',
                          style: TextStyle(fontSize: 12.5, color: Colors.white, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(AppColors c, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border), borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(fontSize: 9.5, color: c.light), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
