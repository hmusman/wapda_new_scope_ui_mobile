import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  String _filter = 'All';

  static const _filters = ['All', 'Forms', 'Gallery', 'Videos'];

  static const _forms = [
    ('Society By-Laws 2026.pdf', '1.2 MB'),
    ('NOC Application Form.pdf', '180 KB'),
    ('Visitor Policy.pdf', '240 KB'),
  ];

  static const _gallery = [
    ('Independence Day Mela', Color(0xFFC0512B)),
    ('Health Camp 2026', Color(0xFF5C8A6A)),
    ('Eid Milan Party', Color(0xFFB7822A)),
    ('Sports Gala Finals', Color(0xFF4A7C8C)),
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final showForms = _filter == 'All' || _filter == 'Forms';
    final showGallery = _filter == 'All' || _filter == 'Gallery' || _filter == 'Videos';

    return AppScaffold(
      body: Padding(
        padding: kScreenPadTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Media Hub', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((f) => FilterChip2(label: f, active: _filter == f, onTap: () => setState(() => _filter = f))).toList(),
              ),
            ),
            const SizedBox(height: 20),
            if (showForms) ...[
              SectionHeading(title: 'OFFICE FORMS & DOCUMENTS'),
              ..._forms.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppCard(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.picture_as_pdf_outlined, color: c.danger, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(f.$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                                const SizedBox(height: 2),
                                Text(f.$2, style: TextStyle(fontSize: 11, color: c.light)),
                              ],
                            ),
                          ),
                          Text('Open', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: s.accent.accent)),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 14),
            ],
            if (showGallery) ...[
              SectionHeading(title: 'EVENT GALLERY & VIDEOS'),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: _gallery.map((g) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [g.$2, g.$2.withOpacity(0.6)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(11),
                    alignment: Alignment.bottomLeft,
                    child: Text(g.$1, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
