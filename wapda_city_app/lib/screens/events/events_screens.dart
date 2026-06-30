import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

Color _coverColor(AppColors c, String key) {
  switch (key) {
    case 'success':
      return c.success;
    case 'amber':
      return c.amber;
    default:
      return c.primary;
  }
}

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedDate = 0;

  static const _dates = [
    ('SAT', '28'),
    ('SUN', '29'),
    ('MON', '30'),
    ('TUE', '01'),
    ('WED', '02'),
    ('THU', '03'),
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'Events',
      trailing: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today_outlined, size: 14, color: s.accent.accent),
            const SizedBox(width: 5),
            Text('Calendar', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: s.accent.accent)),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 9),
              itemBuilder: (context, i) {
                final active = _selectedDate == i;
                final (dow, day) = _dates[i];
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = i),
                  child: Container(
                    width: 48,
                    decoration: BoxDecoration(
                      color: active ? s.accent.accent : c.surface,
                      border: Border.all(color: active ? s.accent.accent : c.border),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(dow, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: active ? Colors.white70 : c.light)),
                        const SizedBox(height: 4),
                        Text(day, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: active ? Colors.white : c.ink)),
                        const SizedBox(height: 3),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == 5 ? (active ? Colors.white : s.accent.accent) : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          ...mockEvents.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: GestureDetector(
                  onTap: () => s.nav(AppScreen.eventDetail),
                  child: Container(
                    decoration: BoxDecoration(
                      color: c.surface,
                      border: Border.all(color: c.border, width: 1.5),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: c.shadow, blurRadius: 10, offset: const Offset(0, 2))],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [_coverColor(c, e.coverColor), _coverColor(c, e.coverColor).withOpacity(0.7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: const EdgeInsets.all(13),
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(20)),
                            child: Text('${e.going} GOING', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.title, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 13, color: c.light),
                                  const SizedBox(width: 5),
                                  Text('${e.date} · ${e.time}', style: TextStyle(fontSize: 11.5, color: c.light)),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(Icons.place_outlined, size: 13, color: c.light),
                                  const SizedBox(width: 5),
                                  Text(e.location, style: TextStyle(fontSize: 11.5, color: c.light)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final EventItem e = mockEvents.first;
    final cover = _coverColor(c, e.coverColor);

    return AppScaffold(
      bleedTop: true,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(gradient: LinearGradient(colors: [cover, cover.withOpacity(0.65)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
              Positioned(
                top: topInset(context) + 14,
                left: 18,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => s.back(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.22), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 18,
                child: Text(e.title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(c, Icons.access_time, '${e.date} · ${e.time}'),
                  const SizedBox(height: 12),
                  _infoRow(c, Icons.place_outlined, e.location),
                  const SizedBox(height: 18),
                  Text(e.description, style: TextStyle(fontSize: 13.5, color: c.mid, height: 1.6)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        height: 34,
                        width: 86,
                        child: Stack(
                          children: List.generate(4, (i) {
                            return Positioned(
                              left: i * 20.0,
                              child: InitialsAvatar(initials: '••', size: 34, bg: s.accent.accent.withOpacity(0.85 - i * 0.1)),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${e.going} people going', style: TextStyle(fontSize: 12.5, color: c.mid, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 26),
                  PrimaryButton(label: "I'M GOING", onTap: () => s.back()),
                  const SizedBox(height: 10),
                  OutlineAccentButton(label: 'Maybe', onTap: () => s.back()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(AppColors c, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 17, color: c.light),
        const SizedBox(width: 9),
        Text(text, style: TextStyle(fontSize: 13.5, color: c.mid, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
