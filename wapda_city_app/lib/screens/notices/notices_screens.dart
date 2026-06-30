import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final categories = ['All', 'Emergency', 'Financial', 'Maintenance', 'Governance', 'Security'];
    final filtered = _filter == 'All' ? mockNotices : mockNotices.where((n) => n.category == _filter).toList();
    final unread = mockNotices.where((n) => n != mockNotices.last).length;

    return SubScreen(
      title: 'Notice Board',
      trailing: unread > 0
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(color: c.danger, borderRadius: BorderRadius.circular(20)),
              child: Text('$unread UNREAD', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((f) => FilterChip2(label: f, active: _filter == f, onTap: () => setState(() => _filter = f))).toList(),
            ),
          ),
          const SizedBox(height: 16),
          ...filtered.asMap().entries.map((entry) {
            final i = entry.key;
            final n = entry.value;
            final isRead = i >= 2;
            final emergency = n.category == 'Emergency' || n.category == 'Security';
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Opacity(
                opacity: isRead ? 0.85 : 1,
                child: GestureDetector(
                  onTap: () => s.nav(AppScreen.noticeDetail),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: c.surface,
                      border: Border.all(color: emergency ? c.danger : c.border, width: emergency ? 1.4 : 1.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (n.pinned)
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(color: c.amberTint, borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.push_pin, size: 11, color: c.gold),
                                const SizedBox(width: 5),
                                Text('PINNED BY MC', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: c.gold)),
                              ],
                            ),
                          ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(n.title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                            ),
                            if (!isRead)
                              Container(
                                margin: const EdgeInsets.only(left: 8, top: 4),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(color: s.accent.accent, shape: BoxShape.circle),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(n.body, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: c.mid, height: 1.4)),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            if (emergency) ...[
                              StatusPill(text: n.category.toUpperCase(), color: c.danger, tint: c.dangerTint),
                              const SizedBox(width: 8),
                            ] else ...[
                              StatusPill(text: n.category.toUpperCase(), color: s.accent.accent, tint: c.primaryTint),
                              const SizedBox(width: 8),
                            ],
                            Text(isRead ? '${n.date} · read' : n.date, style: TextStyle(fontSize: 11, color: c.light)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(child: Text('No notices here.', style: TextStyle(color: c.light, fontSize: 13))),
            ),
        ],
      ),
    );
  }
}

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final NoticeItem n = mockNotices.first;

    return SubScreen(
      title: 'Notice',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (n.pinned) ...[
                StatusPill(text: 'PINNED', color: c.gold, tint: c.amberTint),
                const SizedBox(width: 8),
              ],
              StatusPill(text: n.category.toUpperCase(), color: c.primary, tint: c.primaryTint),
            ],
          ),
          const SizedBox(height: 12),
          Text(n.title, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: c.maroon, borderRadius: BorderRadius.circular(11)),
                child: const Icon(Icons.shield_outlined, color: Colors.white, size: 19),
              ),
              const SizedBox(width: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Management Committee', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                  Text('Posted ${n.date}, 11:00 AM', style: TextStyle(fontSize: 11.5, color: c.light)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(n.body, style: TextStyle(fontSize: 13.5, color: c.mid, height: 1.6)),
          const SizedBox(height: 14),
          Text(
            '• Block A & B: 9:00 AM – 11:30 AM\n• Block C & D: 11:30 AM – 2:00 PM\n• Overhead tanks will be refilled immediately after cleaning',
            style: TextStyle(fontSize: 13, color: c.mid, height: 1.8),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Icon(Icons.picture_as_pdf_outlined, color: c.danger, size: 22),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cleaning_Schedule.pdf', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: c.ink)),
                      Text('214 KB', style: TextStyle(fontSize: 11, color: c.light)),
                    ],
                  ),
                ),
                Text('Open', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: c.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
