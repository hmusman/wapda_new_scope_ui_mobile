import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final isLocal = s.dirTab == DirTab.local;

    return AppScaffold(
      scrollable: false,
      body: Stack(
        children: [
          Column(
            children: [
              DetailHeader(title: 'Directory'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SegmentedTabs(
                        labels: const ['Local Residents', 'Service Providers'],
                        activeIndex: s.dirTab.index,
                        onChanged: (i) => s.setDirTab(DirTab.values[i]),
                      ),
                      const SizedBox(height: 16),
                      if (isLocal)
                        ...mockDirectoryLocal.map((d) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: AppCard(
                                onTap: () => s.nav(AppScreen.chat),
                                child: Row(
                                  children: [
                                    InitialsAvatar(initials: d.initials, bg: s.accent.accent.withOpacity(0.15), fg: s.accent.accent),
                                    const SizedBox(width: 13),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(d.name, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                                              const SizedBox(width: 6),
                                              Icon(Icons.verified, size: 14, color: c.success),
                                            ],
                                          ),
                                          const SizedBox(height: 3),
                                          Text(d.subtitle, style: TextStyle(fontSize: 11.5, color: c.light)),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.chat_bubble_outline, size: 19, color: c.light),
                                  ],
                                ),
                              ),
                            ))
                      else
                        ...mockServiceProviders.map((p) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: AppCard(
                                onTap: () => s.nav(AppScreen.providerDetail),
                                child: Row(
                                  children: [
                                    InitialsAvatar(initials: p.initials, bg: c.slate.withOpacity(0.15), fg: c.slate),
                                    const SizedBox(width: 13),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(p.name, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                                          const SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Text(p.category, style: TextStyle(fontSize: 11.5, color: c.light)),
                                              const SizedBox(width: 8),
                                              Icon(Icons.star, size: 12, color: c.gold),
                                              const SizedBox(width: 2),
                                              Text(p.rating.toString(), style: TextStyle(fontSize: 11.5, color: c.light)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios, size: 14, color: c.light),
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
              onTap: () => s.nav(isLocal ? AppScreen.dirAddSelf : AppScreen.dirAddWorker),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: c.shadow, blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(isLocal ? 'Add yourself' : 'List a worker', style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DirAddSelfScreen extends StatelessWidget {
  const DirAddSelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final id = s.identity;

    return SubScreen(
      title: 'Add Yourself to Directory',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Other residents will be able to see and message you.', style: TextStyle(fontSize: 12.5, color: c.mid, height: 1.5)),
          const SizedBox(height: 18),
          const FieldLabel('Full Name'),
          AppField(initialValue: id.name, readOnly: true),
          const SizedBox(height: 14),
          const FieldLabel('House / Block'),
          AppField(initialValue: id.prop, readOnly: true),
          const SizedBox(height: 14),
          const FieldLabel('Phone Number'),
          const AppField(initialValue: '+92 300 1234567', readOnly: true),
          const SizedBox(height: 24),
          PrimaryButton(label: 'SUBMIT FOR APPROVAL', onTap: () => s.back()),
        ],
      ),
    );
  }
}

class DirAddWorkerScreen extends StatelessWidget {
  const DirAddWorkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'List a Service Worker',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Submit a worker for MC verification before they appear in the directory.', style: TextStyle(fontSize: 12.5, color: c.mid, height: 1.5)),
          const SizedBox(height: 18),
          const FieldLabel('Worker Name'),
          const AppField(hint: 'e.g. Iqbal Electricians', readOnly: true),
          const SizedBox(height: 14),
          const FieldLabel('Category'),
          AppField(hint: 'Electrician', readOnly: true, prefix: Icon(Icons.arrow_drop_down, color: c.mid)),
          const SizedBox(height: 14),
          const FieldLabel('Phone Number'),
          const AppField(hint: '+92 3xx xxxxxxx', readOnly: true),
          const SizedBox(height: 24),
          PrimaryButton(label: 'SUBMIT FOR APPROVAL', onTap: () => s.back()),
        ],
      ),
    );
  }
}

class ProviderDetailScreen extends StatelessWidget {
  const ProviderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final ServiceProvider p = mockServiceProviders.first;

    return SubScreen(
      title: 'Service Provider',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                InitialsAvatar(initials: p.initials, size: 68, bg: c.slate.withOpacity(0.15), fg: c.slate),
                const SizedBox(height: 12),
                Text(p.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: c.ink)),
                const SizedBox(height: 4),
                Text(p.category, style: TextStyle(fontSize: 12.5, color: c.light)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _statBox(c, p.rating.toString(), 'RATING')),
              const SizedBox(width: 10),
              Expanded(child: _statBox(c, '120+', 'JOBS DONE')),
              const SizedBox(width: 10),
              Expanded(child: _statBox(c, 'Verified', 'STATUS')),
            ],
          ),
          const SizedBox(height: 18),
          Text(p.description, style: TextStyle(fontSize: 13, color: c.mid, height: 1.6)),
          const SizedBox(height: 20),
          Text('Recent Reviews', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (i) => Icon(Icons.star, size: 13, color: i < 5 ? c.gold : c.border)),
                ),
                const SizedBox(height: 6),
                Text('"Quick response, fixed the issue same day."', style: TextStyle(fontSize: 12.5, color: c.mid, fontStyle: FontStyle.italic)),
                const SizedBox(height: 4),
                Text('— Sana Tariq, H-118', style: TextStyle(fontSize: 11, color: c.light)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Call & Reveal Number', onTap: () {}),
        ],
      ),
    );
  }

  Widget _statBox(AppColors c, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(fontSize: 9.5, color: c.light, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final ChatThread thread = mockChats.first;

    return AppScaffold(
      scrollable: false,
      body: Column(
        children: [
          DetailHeader(
            title: thread.withName,
            trailing: InitialsAvatar(initials: thread.initials, size: 34, bg: s.accent.accent.withOpacity(0.15), fg: s.accent.accent),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: thread.messages.map((m) {
                return Align(
                  alignment: m.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    constraints: const BoxConstraints(maxWidth: 260),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: m.fromMe ? s.accent.accent : c.surface2,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.text, style: TextStyle(fontSize: 13, color: m.fromMe ? Colors.white : c.ink, height: 1.4)),
                        const SizedBox(height: 4),
                        Text(m.time, style: TextStyle(fontSize: 10, color: m.fromMe ? Colors.white70 : c.light)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            decoration: BoxDecoration(color: c.surface, border: Border(top: BorderSide(color: c.border))),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                    decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(22)),
                    child: Text('Type a message…', style: TextStyle(fontSize: 13, color: c.light)),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: s.accent.accent),
                  child: const Icon(Icons.send, size: 17, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
