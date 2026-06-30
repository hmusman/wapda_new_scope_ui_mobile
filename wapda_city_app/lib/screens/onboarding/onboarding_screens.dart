import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_screen.dart';
import '../../models/user_role.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

const _splashGradient = [Color(0xFF5E2419), Color(0xFFA8431F), Color(0xFFC76A31)];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2300), () {
      if (mounted) context.read<AppState>().splashDone();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: false,
      bleedTop: true,
      backgroundColor: _splashGradient[1],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: _splashGradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 148,
                  height: 148,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(38),
                    boxShadow: const [BoxShadow(color: Color(0x52000000), blurRadius: 55, offset: Offset(0, 22))],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
                ),
                const SizedBox(height: 28),
                const Text('WAPDA City', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 5),
                const Text('Your Society. Connected.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white70)),
              ],
            ),
            const Positioned(bottom: 74, child: _LoadingDots()),
            const Positioned(
              bottom: 38,
              child: Text('Faisalabad, Pakistan', style: TextStyle(fontSize: 11, color: Colors.white60)),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final t = (_c.value - i * 0.18) % 1.0;
            final lift = t < 0.5 ? (t * 2) : (2 - t * 2);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.translate(
                offset: Offset(0, -4 * lift),
                child: Opacity(
                  opacity: 0.3 + 0.7 * lift,
                  child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    return AppScaffold(
      bleedTop: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(28, topInset(context) + 44, 28, 54),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: _splashGradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(34), bottomRight: Radius.circular(34)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 6,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16),
                      border: Border.all(color: Colors.white.withOpacity(0.28)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('EN · اردو', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
                      child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 24),
                    const Text('Welcome to\nWAPDA City',
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2)),
                    const SizedBox(height: 11),
                    const SizedBox(
                      width: 280,
                      child: Text(
                        'The official resident app. Simple, secure, and built for every member of your society.',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white, height: 1.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 34, 26, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      _stat(c, '5', 'User Roles'),
                      _stat(c, '11', 'Services', bordered: true),
                      _stat(c, '24/7', 'Support'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(label: 'CREATE ACCOUNT', gradient: _splashGradient, onTap: () => context.read<AppState>().nav(AppScreen.rolePicker)),
                  const SizedBox(height: 13),
                  OutlineAccentButton(label: 'I ALREADY HAVE AN ACCOUNT', onTap: () => context.read<AppState>().nav(AppScreen.login)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(AppColors c, String value, String label, {bool bordered = false}) {
    return Expanded(
      child: Container(
        decoration: bordered ? BoxDecoration(border: Border(left: BorderSide(color: c.border), right: BorderSide(color: c.border))) : null,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: c.primary)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, color: c.mid)),
          ],
        ),
      ),
    );
  }
}

class RolePickerScreen extends StatelessWidget {
  const RolePickerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final s = context.read<AppState>();
    final roles = [
      (UserRole.member, 'Member', '/ Owner', 'Registered property owner · full access', Icons.home_outlined, c.primaryTint, c.primary),
      (UserRole.family, 'Family Member', '', 'Family of an owner · full access', Icons.diversity_3_outlined, c.amberTint, c.amber),
      (UserRole.tenant, 'Tenant', '', 'Renting · all features except billing', Icons.apartment_outlined, c.successTint, c.success),
      (UserRole.employee, 'WC Employee', '', 'Society staff · register with HR ID', Icons.badge_outlined, const Color(0xFFE2EDF1), c.slate),
    ];
    return AppScaffold(
      body: Padding(
        padding: kScreenPad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackCircle(),
            const SizedBox(height: 22),
            Text('Who are you?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 6),
            Text('Choose your role to register. Your access is tailored to it.', style: TextStyle(fontSize: 13.5, color: c.mid)),
            const SizedBox(height: 24),
            for (final r in roles) ...[
              AppCard(
                onTap: () => s.pickRole(r.$1, AppScreen.regProperty),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: r.$6, borderRadius: BorderRadius.circular(14)),
                      child: Icon(r.$5, color: r.$7),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: c.ink),
                              children: [
                                TextSpan(text: r.$2),
                                if (r.$3.isNotEmpty) TextSpan(text: ' ${r.$3}', style: TextStyle(color: c.light, fontWeight: FontWeight.w500, fontSize: 13)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(r.$4, style: TextStyle(fontSize: 12, color: c.mid)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: c.light),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Management Committee accounts are provisioned by the society office.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.5, color: c.mid),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _stepHeader(BuildContext context, int step, int of, String label) {
  final c = colorsOf(context);
  final accent = context.watch<AppState>().accent.accent;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const BackCircle(),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(of, (i) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: i == of - 1 ? 0 : 6),
                    height: 5,
                    decoration: BoxDecoration(color: i < step ? accent : c.border, borderRadius: BorderRadius.circular(3)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 11, color: c.mid)),
          ],
        ),
      ),
    ],
  );
}

class RegPropertyScreen extends StatelessWidget {
  const RegPropertyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final s = context.watch<AppState>();
    final accent = s.accent.accent;
    return AppScaffold(
      body: Padding(
        padding: kScreenPad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _stepHeader(context, 1, 3, 'Step 1 of 3 · Verify ${s.regRoleLabel}'),
            const SizedBox(height: 24),
            if (s.regIsEmployee) ...[
              Text('Employee Verification', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: c.ink)),
              const SizedBox(height: 6),
              Text('Enter your HR / Employee ID. An OTP will be sent to your registered mobile.', style: TextStyle(fontSize: 13.5, color: c.mid)),
              const SizedBox(height: 24),
              const FieldLabel('HR / Employee ID'),
              AppField(initialValue: 'WC-EMP-3391', readOnly: true, borderColor: accent),
              const SizedBox(height: 16),
              const FieldLabel('Registered Mobile'),
              const AppField(initialValue: '+92 3xx xxxxxxx', readOnly: true),
            ] else ...[
              Text('Find your property', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: c.ink)),
              const SizedBox(height: 6),
              Text(s.regOtpHint, style: TextStyle(fontSize: 13.5, color: c.mid)),
              const SizedBox(height: 24),
              const FieldLabel('Property Number'),
              AppField(initialValue: 'H-247, Block C', readOnly: true, borderColor: accent, prefix: Icon(Icons.home_outlined, size: 18, color: accent)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(color: c.surface2, border: Border.all(color: c.border), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18, color: accent),
                    const SizedBox(width: 9),
                    Expanded(child: Text(s.regRelayNote, style: TextStyle(fontSize: 12, color: c.mid, height: 1.5))),
                  ],
                ),
              ),
            ],
            const Spacer(),
            PrimaryButton(label: 'SEND OTP', onTap: () => s.nav(AppScreen.regOtp)),
          ],
        ),
      ),
    );
  }
}

class RegOtpScreen extends StatelessWidget {
  const RegOtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final s = context.watch<AppState>();
    final accent = s.accent.accent;
    const digits = ['4', '9', '2'];
    return AppScaffold(
      body: Padding(
        padding: kScreenPad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackCircle(),
            const SizedBox(height: 28),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(gradient: LinearGradient(colors: s.accent.gradient), borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.sms_outlined, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text('Enter the 6-digit code', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 8),
            Text(s.regOtpTarget, style: TextStyle(fontSize: 13.5, color: c.mid, height: 1.5)),
            const SizedBox(height: 30),
            Row(
              children: List.generate(6, (i) {
                final filled = i < digits.length;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: i == 5 ? 0 : 9),
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: c.surface,
                      border: Border.all(color: filled ? accent : c.border, width: 2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: filled ? Text(digits[i], style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: c.ink)) : null,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13.5, color: c.mid),
                  children: [
                    const TextSpan(text: 'Resend code in '),
                    TextSpan(text: '0:48', style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(label: 'VERIFY', onTap: () => s.nav(AppScreen.regProfile)),
          ],
        ),
      ),
    );
  }
}

class RegProfileScreen extends StatelessWidget {
  const RegProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final s = context.watch<AppState>();
    final accent = s.accent.accent;
    return AppScaffold(
      body: Padding(
        padding: kScreenPad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _stepHeader(context, 3, 3, 'Step 3 of 3 · Your Profile'),
            const SizedBox(height: 22),
            Text('Complete your profile', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 18),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(gradient: LinearGradient(colors: s.accent.gradient), shape: BoxShape.circle),
                    child: const Icon(Icons.person_outline, color: Colors.white, size: 34),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(color: c.surface, shape: BoxShape.circle, border: Border.all(color: accent, width: 2)),
                      child: Icon(Icons.add, size: 14, color: accent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Center(child: Text('Photo optional', style: TextStyle(fontSize: 11.5, color: c.light))),
            const SizedBox(height: 18),
            const FieldLabel('Full Name *'),
            const AppField(initialValue: 'Ahsan Raza', readOnly: true),
            const SizedBox(height: 14),
            const FieldLabel('Email *'),
            const AppField(initialValue: 'ahsan@email.com', readOnly: true),
            const SizedBox(height: 14),
            const FieldLabel('Mobile Number *'),
            const AppField(initialValue: '+92 300 1234567', readOnly: true),
            if (s.regIsFamily) ...[
              const SizedBox(height: 14),
              const FieldLabel('Relationship with owner *'),
              Container(
                margin: const EdgeInsets.only(top: 7),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border, width: 1.5), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Brother', style: TextStyle(color: c.ink, fontSize: 14)),
                    Icon(Icons.keyboard_arrow_down, color: c.light),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              'Gender, date of birth and blood group are optional — add them anytime from your profile.',
              style: TextStyle(fontSize: 11.5, color: c.light),
            ),
            const SizedBox(height: 20),
            PrimaryButton(label: 'CREATE ACCOUNT', onTap: () => s.nav(AppScreen.regPending)),
          ],
        ),
      ),
    );
  }
}

class RegPendingScreen extends StatelessWidget {
  const RegPendingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final s = context.watch<AppState>();
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 70, 30, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(color: c.amberTint, shape: BoxShape.circle),
              child: Icon(Icons.apartment, size: 50, color: c.amber),
            ),
            const SizedBox(height: 32),
            Text('Submitted for approval', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 12),
            SizedBox(
              width: 280,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 13.5, color: c.mid, height: 1.65),
                  children: [
                    const TextSpan(text: 'The Management Committee will verify your details within '),
                    TextSpan(text: '24–48 hours', style: TextStyle(color: c.ink, fontWeight: FontWeight.w700)),
                    const TextSpan(text: ". You'll be notified once approved."),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(label: 'PREVIEW APP (DEMO)', onTap: () => s.enterApp()),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => s.nav(AppScreen.welcome),
              child: Text('Back to start', style: TextStyle(fontSize: 13, color: c.mid)),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    final s = context.watch<AppState>();
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(26, 70, 26, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackCircle(),
            const SizedBox(height: 24),
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: c.surface,
                border: Border.all(color: c.border),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [BoxShadow(color: c.shadow, blurRadius: 18, offset: const Offset(0, 6))],
              ),
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
            const SizedBox(height: 22),
            Text('Welcome Back', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: c.ink)),
            const SizedBox(height: 6),
            Text('Log in with your property number', style: TextStyle(fontSize: 13.5, color: c.mid)),
            const SizedBox(height: 26),
            Text('Property Number', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.primary)),
            AppField(initialValue: 'H-247, Block C', readOnly: true, borderColor: c.primary),
            const SizedBox(height: 16),
            const FieldLabel('Mobile / OTP login'),
            const AppField(initialValue: '+92 300 1234567', readOnly: true),
            const SizedBox(height: 24),
            PrimaryButton(label: 'SEND OTP & LOGIN', gradient: _splashGradient, onTap: () => s.enterApp()),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: Divider(color: c.border)),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('or', style: TextStyle(fontSize: 12, color: c.light))),
                Expanded(child: Divider(color: c.border)),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _miniButton(c, 'Employee ID')),
                const SizedBox(width: 12),
                Expanded(child: _miniButton(c, 'Biometric')),
              ],
            ),
            const SizedBox(height: 28),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13.5, color: c.mid),
                  children: [
                    const TextSpan(text: 'New here? '),
                    TextSpan(
                      text: 'Create account',
                      style: TextStyle(color: c.primary, fontWeight: FontWeight.w700),
                      recognizer: (TapGestureRecognizer()..onTap = () => s.nav(AppScreen.rolePicker)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniButton(AppColors c, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border, width: 1.5), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
    );
  }
}
