import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class PollsScreen extends StatefulWidget {
  const PollsScreen({super.key});

  @override
  State<PollsScreen> createState() => _PollsScreenState();
}

class _PollsScreenState extends State<PollsScreen> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final active = mockPolls.firstWhere((p) => !p.closed && !p.votedByMe, orElse: () => mockPolls.first);
    final past = mockPolls.where((p) => p.id != active.id).toList();

    return AppScaffold(
      body: Padding(
        padding: kScreenPadTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Polls & Voting', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: c.surface,
                border: Border.all(color: s.accent.accent, width: 1.4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StatusPill(text: 'ACTIVE', color: c.success, tint: c.successTint),
                      const SizedBox(width: 8),
                      Text('${active.totalVotes} votes so far', style: TextStyle(fontSize: 11.5, color: c.light)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(active.question, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: c.ink)),
                  const SizedBox(height: 14),
                  ...active.options.asMap().entries.map((entry) {
                    final i = entry.key;
                    final isSel = _selected == i;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => setState(() => _selected = i),
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: isSel ? s.accent.accent.withOpacity(0.1) : c.surface2,
                            border: Border.all(color: isSel ? s.accent.accent : c.border, width: isSel ? 1.6 : 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 19,
                                height: 19,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: isSel ? s.accent.accent : c.border, width: 1.6),
                                  color: isSel ? s.accent.accent : Colors.transparent,
                                ),
                                child: isSel ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                              ),
                              const SizedBox(width: 11),
                              Expanded(child: Text(entry.value, style: TextStyle(fontSize: 13, color: c.ink))),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  PrimaryButton(label: 'SUBMIT VOTE', enabled: _selected != -1, onTap: () => s.nav(AppScreen.pollResults)),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text('Past Polls', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 10),
            ...past.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppCard(
                    onTap: () => s.nav(AppScreen.pollResults),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.question, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                              const SizedBox(height: 5),
                              Text('${p.totalVotes} votes · ${p.closed ? 'Closed' : 'You voted'}', style: TextStyle(fontSize: 11, color: c.light)),
                            ],
                          ),
                        ),
                        Icon(Icons.bar_chart, color: c.light, size: 19),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

class PollResultsScreen extends StatelessWidget {
  const PollResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final Poll p = mockPolls.first;
    final total = p.totalVotes == 0 ? 1 : p.totalVotes;

    return SubScreen(
      title: 'Poll Results',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusPill(text: p.closed ? 'CLOSED' : 'ACTIVE', color: p.closed ? c.light : c.success, tint: p.closed ? c.surface2 : c.successTint),
              const SizedBox(width: 8),
              Text('${p.totalVotes} total votes', style: TextStyle(fontSize: 11.5, color: c.light)),
            ],
          ),
          const SizedBox(height: 10),
          Text(p.question, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 22),
          ...p.options.asMap().entries.map((entry) {
            final i = entry.key;
            final pct = p.votes[i] / total;
            final isTop = p.votes[i] == p.votes.reduce((a, b) => a > b ? a : b);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(entry.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink))),
                      Text('${(pct * 100).round()}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isTop ? c.primary : c.mid)),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 9,
                      backgroundColor: c.surface2,
                      valueColor: AlwaysStoppedAnimation(isTop ? c.primary : c.mid.withOpacity(0.5)),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(border: Border.all(color: c.gold, width: 1.3), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MC REMARKS', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: c.gold, letterSpacing: 0.6)),
                const SizedBox(height: 6),
                Text('Thank you for participating. The committee will review the results and announce the final decision in the next general session.',
                    style: TextStyle(fontSize: 12.5, color: c.mid, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
