import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';

/// Circular back-arrow button used at the top of nearly every sub-screen.
class BackCircle extends StatelessWidget {
  final VoidCallback? onTap;
  const BackCircle({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AppState>().colors;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap ?? () => context.read<AppState>().back(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: c.surface,
          border: Border.all(color: c.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.arrow_back_ios_new, size: 18, color: c.ink),
      ),
    );
  }
}

/// Full-width gradient primary button — mirrors `.press` button with
/// `--accent-grad` background.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final List<Color>? gradient;
  final bool enabled;
  const PrimaryButton({super.key, required this.label, this.onTap, this.gradient, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final grad = gradient ?? s.accent.gradient;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: enabled ? onTap : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: grad, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: s.colors.shadow, blurRadius: 24, offset: const Offset(0, 10))],
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.4),
          ),
        ),
      ),
    );
  }
}

/// Full-width outlined button — accent-coloured border + text.
class OutlineAccentButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const OutlineAccentButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final accent = s.accent.accent;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: accent, width: 1.6),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(label, style: TextStyle(color: accent, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.4)),
      ),
    );
  }
}

/// Field label — mirrors `.lbl`.
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    final c = context.watch<AppState>().colors;
    return Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.mid));
  }
}

/// Text input — mirrors `.fld`.
class AppField extends StatelessWidget {
  final String? hint;
  final String? initialValue;
  final bool readOnly;
  final bool obscure;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;
  final Widget? prefix;
  const AppField({
    super.key,
    this.hint,
    this.initialValue,
    this.readOnly = false,
    this.obscure = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.borderColor,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AppState>().colors;
    return Container(
      margin: const EdgeInsets.only(top: 7),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.all(color: borderColor ?? c.border, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: prefix != null ? const EdgeInsets.symmetric(horizontal: 14) : EdgeInsets.zero,
      child: Row(
        children: [
          if (prefix != null) ...[prefix!, const SizedBox(width: 8)],
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              readOnly: readOnly,
              obscureText: obscure,
              keyboardType: keyboardType,
              maxLines: maxLines,
              onChanged: onChanged,
              style: TextStyle(fontSize: 14, color: c.ink, fontFamily: 'Poppins'),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: c.light, fontSize: 14),
                border: InputBorder.none,
                contentPadding: prefix != null ? const EdgeInsets.symmetric(vertical: 14) : const EdgeInsets.all(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Round avatar with initials, used across header/profile/directory screens.
class InitialsAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final Color? bg;
  final Color? fg;
  const InitialsAvatar({super.key, required this.initials, this.size = 44, this.bg, this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg ?? Colors.white.withOpacity(0.22), shape: BoxShape.circle),
      child: Text(initials, style: TextStyle(color: fg ?? Colors.white, fontSize: size * 0.36, fontWeight: FontWeight.w700)),
    );
  }
}

/// Small rounded status pill, e.g. "Pending", "Resolved", "Active".
class StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  final Color tint;
  const StatusPill({super.key, required this.text, required this.color, required this.tint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }
}

/// Section header used above lists — bold title + optional trailing action.
class SectionHeading extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionHeading({super.key, required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: s.colors.ink)),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              child: Text(action!, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: s.accent.accent)),
            ),
        ],
      ),
    );
  }
}

/// Card container — mirrors the repeated `surface + border + radius16 + shadow` pattern.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  const AppCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AppState>().colors;
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.all(color: c.border, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: c.shadow, blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: child,
    );
    if (onTap == null) return card;
    return InkWell(borderRadius: BorderRadius.circular(16), onTap: onTap, child: card);
  }
}

/// Segmented tab bar (2-3 segments) — mirrors the bill/directory/community sub-tabs.
class SegmentedTabs extends StatelessWidget {
  final List<String> labels;
  final int activeIndex;
  final ValueChanged<int> onChanged;
  const SegmentedTabs({super.key, required this.labels, required this.activeIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    return Container(
      decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(labels.length, (i) {
          final active = i == activeIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? c.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: active ? [BoxShadow(color: c.shadow, blurRadius: 6)] : null,
                ),
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: active ? s.accent.accent : c.mid,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Filter chip used in community/marketplace/notices filter rows.
class FilterChip2 extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const FilterChip2({super.key, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? s.accent.accent : c.surface,
          border: Border.all(color: active ? s.accent.accent : c.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: active ? Colors.white : c.mid)),
      ),
    );
  }
}

extension ColorAlpha on Color {
  Color tint(double opacity) => withOpacity(opacity);
}

/// Screen padding constant used across most screens (matches `padding:62px 26px 30px`).
const EdgeInsets kScreenPad = EdgeInsets.fromLTRB(26, 28, 26, 30);
const EdgeInsets kScreenPadTop = EdgeInsets.fromLTRB(26, 20, 26, 30);

AppColors colorsOf(BuildContext context) => context.watch<AppState>().colors;

/// Sticky-looking top bar used on nearly every secondary screen:
/// back arrow + title (+ optional trailing widget).
class DetailHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onBack;
  const DetailHeader({super.key, required this.title, this.trailing, this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(54);

  @override
  Widget build(BuildContext context) {
    final c = colorsOf(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(color: c.surface, border: Border(bottom: BorderSide(color: c.border))),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(11),
            onTap: onBack ?? () => context.read<AppState>().back(),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: c.bg, borderRadius: BorderRadius.circular(11)),
              child: Icon(Icons.arrow_back_ios_new, size: 18, color: c.ink),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.ink))),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Standard sub-screen scaffold: [DetailHeader] + scrollable body, no bottom nav.
class SubScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsets padding;
  const SubScreen({super.key, required this.title, required this.child, this.trailing, this.padding = const EdgeInsets.all(18)});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: false,
      body: Column(
        children: [
          DetailHeader(title: title, trailing: trailing),
          Expanded(child: SingleChildScrollView(child: Padding(padding: padding, child: child))),
        ],
      ),
    );
  }
}
