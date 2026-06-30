import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_screen.dart';
import '../../state/app_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();

    return AppScaffold(
      bleedTop: true,
      backgroundColor: const Color(0xFF2A0E0A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF5E2419), Color(0xFF2A0E0A)],
            radius: 1.1,
            center: Alignment.center,
          ),
        ),
        padding: EdgeInsets.fromLTRB(26, topInset(context) + 20, 26, 30),
        child: Column(
          children: [
            const Text('Emergency SOS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 6),
            const Text('Press and hold to alert the security desk', style: TextStyle(fontSize: 12.5, color: Colors.white70)),
            const Spacer(),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFBF3B2B),
                boxShadow: [
                  BoxShadow(color: const Color(0xFFBF3B2B).withOpacity(0.55), blurRadius: 50, spreadRadius: 8),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.white, size: 38),
                  SizedBox(height: 6),
                  Text('SOS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1.4)),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
                    child: const Icon(Icons.shield_outlined, color: Colors.white, size: 21),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nearest Guard · Gate 1', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                        Text('Avg response time: 2 min', style: TextStyle(fontSize: 11, color: Colors.white70)),
                      ],
                    ),
                  ),
                  const Icon(Icons.call, color: Colors.white, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () => s.tabNav(AppTab.home),
              child: const Text('Cancel', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
