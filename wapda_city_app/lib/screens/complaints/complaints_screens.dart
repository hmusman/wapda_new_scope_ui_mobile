import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  String _filter = 'Open';

  Color _statusColor(AppColors c, String status) {
    switch (status) {
      case 'Open':
        return c.primary;
      case 'In Progress':
        return const Color(0xFF92600F);
      case 'Resolved':
        return c.success;
      default:
        return c.mid;
    }
  }

  Color _statusTint(AppColors c, String status) {
    switch (status) {
      case 'Open':
        return c.primaryTint;
      case 'In Progress':
        return c.amberTint;
      case 'Resolved':
        return c.successTint;
      default:
        return c.surface2;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Open':
        return Icons.bolt_outlined;
      case 'In Progress':
        return Icons.history_toggle_off;
      case 'Resolved':
        return Icons.check_circle_outline;
      default:
        return Icons.report_problem_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final filtered = mockComplaints.where((x) => x.status == _filter).toList();

    return AppScaffold(
      scrollable: false,
      body: Stack(
        children: [
          Column(
            children: [
              DetailHeader(title: 'My Complaints'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: ['Open', 'In Progress', 'Resolved']
                            .map((f) => FilterChip2(label: f, active: _filter == f, onTap: () => setState(() => _filter = f)))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      ...filtered.map((x) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Opacity(
                              opacity: x.status == 'Resolved' ? 0.78 : 1,
                              child: AppCard(
                                onTap: () => s.nav(AppScreen.complaintDetail),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(color: _statusTint(c, x.status), borderRadius: BorderRadius.circular(12)),
                                      child: Icon(_statusIcon(x.status), color: _statusColor(c, x.status), size: 21),
                                    ),
                                    const SizedBox(width: 13),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(x.title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                                          const SizedBox(height: 3),
                                          Text('#${x.id} · ${x.category} · ${x.date}', style: TextStyle(fontSize: 11.5, color: c.light)),
                                        ],
                                      ),
                                    ),
                                    StatusPill(text: x.status.toUpperCase(), color: _statusColor(c, x.status), tint: _statusTint(c, x.status)),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      if (filtered.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(child: Text('No complaints here.', style: TextStyle(color: c.light, fontSize: 13))),
                        ),
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
              onTap: () => s.nav(AppScreen.fileComplaint),
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: c.shadow, blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FileComplaintScreen extends StatefulWidget {
  const FileComplaintScreen({super.key});

  @override
  State<FileComplaintScreen> createState() => _FileComplaintScreenState();
}

class _FileComplaintScreenState extends State<FileComplaintScreen> {
  int _category = 0;
  String _description =
      'Streetlight outside H-247 has not turned on for the past 4 nights. The block is completely dark after 9pm, which is a safety concern.';

  static const _categories = [
    (icon: Icons.bolt_outlined, label: 'Electrical'),
    (icon: Icons.water_drop_outlined, label: 'Plumbing'),
    (icon: Icons.cleaning_services_outlined, label: 'Sanitation'),
    (icon: Icons.security_outlined, label: 'Security'),
    (icon: Icons.add_road_outlined, label: 'Roads'),
    (icon: Icons.more_horiz, label: 'Other'),
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'New Complaint',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('1 · Category'),
          const SizedBox(height: 9),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.4,
            children: List.generate(_categories.length, (i) {
              final active = _category == i;
              final cat = _categories[i];
              return GestureDetector(
                onTap: () => setState(() => _category = i),
                child: Container(
                  decoration: BoxDecoration(
                    color: active ? s.accent.accent.withOpacity(0.12) : c.surface,
                    border: Border.all(color: active ? s.accent.accent : c.border, width: active ? 1.6 : 1),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat.icon, size: 22, color: active ? s.accent.accent : c.mid),
                      const SizedBox(height: 6),
                      Text(cat.label, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: active ? s.accent.accent : c.mid)),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          const FieldLabel('2 · Title (predefined)'),
          AppField(hint: 'Frequent power fluctuation', readOnly: true, prefix: Icon(Icons.arrow_drop_down, color: c.mid)),
          const SizedBox(height: 18),
          const FieldLabel('3 · Description'),
          Container(
            margin: const EdgeInsets.only(top: 7),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border, width: 1.5), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _description,
                  maxLines: 4,
                  maxLength: 500,
                  onChanged: (v) => setState(() => _description = v),
                  style: TextStyle(fontSize: 13.5, color: c.ink),
                  decoration: const InputDecoration(border: InputBorder.none, counterText: '', isDense: true),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('${_description.length} / 500', style: TextStyle(fontSize: 11, color: c.light)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _attachBox(c, Icons.image_outlined, 'Attach photos')),
              const SizedBox(width: 12),
              Expanded(child: _attachBox(c, Icons.picture_as_pdf_outlined, 'Attach PDF')),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'SUBMIT COMPLAINT', onTap: () => s.nav(AppScreen.complaintDetail)),
        ],
      ),
    );
  }

  Widget _attachBox(AppColors c, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: c.border, width: 1.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: c.light, size: 22),
          const SizedBox(height: 7),
          Text(label, style: TextStyle(fontSize: 11.5, color: c.mid, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class ComplaintDetailScreen extends StatelessWidget {
  const ComplaintDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final Complaint x = mockComplaints.first;

    final stages = [
      ('Submitted', x.date, true),
      ('Assigned to maintenance team', x.date, x.updates.length > 1),
      ('In Progress — team dispatched', 'Today', x.status != 'Open'),
      ('Resolved', '—', x.status == 'Resolved'),
    ];

    return SubScreen(
      title: 'Complaint #${x.id}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusPill(text: x.status.toUpperCase(), color: const Color(0xFF92600F), tint: c.amberTint),
              const SizedBox(width: 10),
              Text('${x.category} · filed ${x.date}', style: TextStyle(fontSize: 11.5, color: c.light)),
            ],
          ),
          const SizedBox(height: 10),
          Text(x.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 8),
          Text(x.description, style: TextStyle(fontSize: 13, color: c.mid, height: 1.5)),
          const SizedBox(height: 16),
          if (x.status == 'In Progress')
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(color: c.amberTint, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Icon(Icons.timer_outlined, size: 18, color: const Color(0xFF92600F)),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text('Resolution SLA: 4h 18m remaining', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF92600F))),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 22),
          Text('Status Timeline', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 12),
          ...List.generate(stages.length, (i) {
            final (label, date, done) = stages[i];
            final last = i == stages.length - 1;
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done ? c.success : c.surface2,
                          border: Border.all(color: done ? c.success : c.border, width: 2),
                        ),
                      ),
                      if (!last) Expanded(child: Container(width: 2, color: c.border)),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: done ? c.ink : c.light)),
                          const SizedBox(height: 2),
                          Text(date, style: TextStyle(fontSize: 11.5, color: c.light)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (x.status == 'In Progress')
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: c.gold, width: 1.3), borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RESOLVER REMARKS', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: c.gold, letterSpacing: 0.6)),
                  const SizedBox(height: 6),
                  Text('Technician has been assigned and will visit the site within 24 hours to replace the faulty fitting.',
                      style: TextStyle(fontSize: 12.5, color: c.mid, height: 1.5)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
