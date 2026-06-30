import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class EmpDashboardScreen extends StatelessWidget {
  const EmpDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final id = s.identity;
    final assigned = mockComplaints.where((x) => x.status != 'Resolved').toList();

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
                          const Text('Staff Panel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
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
                  Text('Maintenance · ${id.prop} · Access: Complaints + Gate', style: const TextStyle(fontSize: 12, color: Colors.white70)),
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
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border, width: 1.4), borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.qr_code_scanner, color: s.accent.accent, size: 22),
                              const SizedBox(height: 10),
                              Text('Scan Visitor QR', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: c.ink)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => s.nav(AppScreen.visitors),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border, width: 1.4), borderRadius: BorderRadius.circular(14)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.list_alt_outlined, color: s.accent.accent, size: 22),
                                const SizedBox(height: 10),
                                Text('Visitor Logs', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: c.ink)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Assigned Complaints', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
                      StatusPill(text: '${assigned.length} ACTIVE', color: s.accent.accent, tint: c.primaryTint),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...assigned.map((x) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCard(
                          onTap: () => s.nav(AppScreen.complaintDetail),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(x.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                                    const SizedBox(height: 3),
                                    Text('#${x.id} · ${x.category} · ${x.date}', style: TextStyle(fontSize: 11, color: c.light)),
                                  ],
                                ),
                              ),
                              StatusPill(text: x.status.toUpperCase(), color: const Color(0xFF92600F), tint: c.amberTint),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        Icon(Icons.celebration_outlined, color: c.gold, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('Eid Milad — 128 attending', style: TextStyle(fontSize: 12.5, color: c.mid, fontWeight: FontWeight.w600)),
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
}
