import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

Color _visitorStatusColor(AppColors c, String status) {
  switch (status) {
    case 'Expected':
      return c.amber;
    case 'Checked In':
      return c.success;
    default:
      return c.light;
  }
}

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final expected = mockVisitors.where((v) => v.status == 'Expected').length;
    final checkedIn = mockVisitors.where((v) => v.status == 'Checked In').length;

    return AppScaffold(
      scrollable: false,
      body: Stack(
        children: [
          Column(
            children: [
              DetailHeader(title: 'Visitors'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: _statCard(c, expected.toString(), 'Expected')),
                          const SizedBox(width: 10),
                          Expanded(child: _statCard(c, checkedIn.toString(), 'Checked In')),
                          const SizedBox(width: 10),
                          Expanded(child: _statCard(c, mockVisitors.length.toString(), 'Total Today')),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text('Visitor Log', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
                      const SizedBox(height: 10),
                      ...mockVisitors.map((v) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: AppCard(
                              onTap: () => s.nav(AppScreen.visitorPass),
                              child: Row(
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(color: _visitorStatusColor(c, v.status).withOpacity(0.14), borderRadius: BorderRadius.circular(12)),
                                    child: Icon(Icons.person_outline, color: _visitorStatusColor(c, v.status), size: 21),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(v.name, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                                        const SizedBox(height: 3),
                                        Text('${v.purpose} · ${v.time}', style: TextStyle(fontSize: 11.5, color: c.light)),
                                      ],
                                    ),
                                  ),
                                  StatusPill(text: v.status.toUpperCase(), color: _visitorStatusColor(c, v.status), tint: _visitorStatusColor(c, v.status).withOpacity(0.14)),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 18,
            bottom: 18,
            child: GestureDetector(
              onTap: () => s.nav(AppScreen.inviteGuest),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: c.shadow, blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text('Invite Guest', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(AppColors c, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border), borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(fontSize: 10.5, color: c.light)),
        ],
      ),
    );
  }
}

class InviteGuestScreen extends StatefulWidget {
  const InviteGuestScreen({super.key});

  @override
  State<InviteGuestScreen> createState() => _InviteGuestScreenState();
}

class _InviteGuestScreenState extends State<InviteGuestScreen> {
  int _gender = 0;
  int _transport = 0;
  int _duration = 2;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'Invite a Guest',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('Guest Name'),
          const AppField(hint: 'Full name'),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [FieldLabel('Date'), AppField(hint: '30 Jun 2026', readOnly: true, prefix: Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [FieldLabel('Time'), AppField(hint: '4:30 PM', readOnly: true, prefix: Icon(Icons.access_time, size: 16, color: Colors.grey))])),
            ],
          ),
          const SizedBox(height: 14),
          const FieldLabel('Gender'),
          const SizedBox(height: 7),
          Row(
            children: ['Male', 'Female', 'Other'].asMap().entries.map((entry) {
              final active = _gender == entry.key;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _gender = entry.key),
                  child: Container(
                    margin: EdgeInsets.only(right: entry.key < 2 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? s.accent.accent : c.surface,
                      border: Border.all(color: active ? s.accent.accent : c.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(entry.value, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: active ? Colors.white : c.mid)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          const FieldLabel('Transport'),
          const SizedBox(height: 7),
          Row(
            children: ['Walk-in', 'Bike', 'Car'].asMap().entries.map((entry) {
              final active = _transport == entry.key;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _transport = entry.key),
                  child: Container(
                    margin: EdgeInsets.only(right: entry.key < 2 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? s.accent.accent : c.surface,
                      border: Border.all(color: active ? s.accent.accent : c.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(entry.value, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: active ? Colors.white : c.mid)),
                  ),
                ),
              );
            }).toList(),
          ),
          if (_transport != 0) ...[
            const SizedBox(height: 14),
            const FieldLabel('Vehicle Number'),
            const AppField(hint: 'e.g. LEA-1234'),
          ],
          const SizedBox(height: 14),
          const FieldLabel('Expected Duration (hours)'),
          const SizedBox(height: 7),
          Row(
            children: [
              _stepperBtn(c, Icons.remove, () => setState(() => _duration = (_duration - 1).clamp(1, 12))),
              Expanded(
                child: Center(
                  child: Text('$_duration hr${_duration == 1 ? '' : 's'}', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
                ),
              ),
              _stepperBtn(c, Icons.add, () => setState(() => _duration = (_duration + 1).clamp(1, 12))),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'GENERATE QR PASS', onTap: () => s.nav(AppScreen.visitorPass)),
        ],
      ),
    );
  }

  Widget _stepperBtn(AppColors c, IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: 18, color: c.ink),
      ),
    );
  }
}

class VisitorPassScreen extends StatelessWidget {
  const VisitorPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'Visitor Pass',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                const Text('VISITOR PASS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white70, letterSpacing: 1.2)),
                const SizedBox(height: 6),
                const Text('Zara Malik', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white)),
                Text('Guest of ${s.identity.name}', style: const TextStyle(fontSize: 12.5, color: Colors.white70)),
                const SizedBox(height: 18),
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                    itemCount: 49,
                    itemBuilder: (context, i) => Container(
                      margin: const EdgeInsets.all(1),
                      color: (i * 7 + i) % 3 == 0 ? Colors.black : Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Today, 4:30 PM · Valid for 4 hours', style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: OutlineAccentButton(label: 'Share via WhatsApp', onTap: () {}),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.picture_as_pdf_outlined, size: 16, color: c.mid),
                      const SizedBox(width: 8),
                      Text('Share as PDF', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.mid)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
