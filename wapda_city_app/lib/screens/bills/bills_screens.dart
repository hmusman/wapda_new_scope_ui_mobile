import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final pending = mockBills.where((b) => !b.paid).toList();
    final paid = mockBills.where((b) => b.paid).toList();
    final outstanding = pending.fold<double>(0, (a, b) => a + b.amount);

    List<Bill> shown;
    switch (s.billTab) {
      case BillTab.pending:
        shown = pending;
        break;
      case BillTab.paid:
        shown = paid;
        break;
      case BillTab.all:
        shown = mockBills;
        break;
    }

    return SubScreen(
      title: 'Service Charges',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: c.maroon, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Outstanding', style: TextStyle(fontSize: 12, color: Colors.white70)),
                const SizedBox(height: 5),
                Text('PKR ${outstanding.toStringAsFixed(0)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 3),
                Text('${pending.length} pending bill${pending.length == 1 ? '' : 's'} · paid up to ${paid.isNotEmpty ? paid.first.period : '—'}',
                    style: const TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SegmentedTabs(
            labels: const ['Pending', 'Paid', 'All'],
            activeIndex: s.billTab.index,
            onChanged: (i) => s.setBillTab(BillTab.values[i]),
          ),
          const SizedBox(height: 16),
          ...shown.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  onTap: () => s.nav(AppScreen.billDetail),
                  child: Row(
                    children: [
                      Container(width: 4, height: 44, decoration: BoxDecoration(color: b.paid ? c.success : c.amber, borderRadius: BorderRadius.circular(3))),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${b.title} · ${b.period}', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                            const SizedBox(height: 3),
                            Text(
                              b.paid ? 'Paid ${b.paidDate}' : 'Due ${b.dueDate}',
                              style: TextStyle(fontSize: 11.5, color: c.light),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(b.amount.toStringAsFixed(0), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: c.ink)),
                          const SizedBox(height: 5),
                          StatusPill(
                            text: b.paid ? 'PAID' : 'PENDING',
                            color: b.paid ? c.success : const Color(0xFF92600F),
                            tint: b.paid ? c.successTint : c.amberTint,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          if (shown.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(child: Text('No bills here.', style: TextStyle(color: c.light, fontSize: 13))),
            ),
        ],
      ),
    );
  }
}

class BillDetailScreen extends StatelessWidget {
  const BillDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final bill = mockBills.firstWhere((b) => !b.paid, orElse: () => mockBills.first);

    return SubScreen(
      title: 'Bill Detail',
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text('${bill.period} · Bill #WC-2026-${bill.id}', style: TextStyle(fontSize: 12.5, color: c.light)),
                const SizedBox(height: 8),
                Text('PKR ${bill.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: c.ink)),
                const SizedBox(height: 10),
                StatusPill(
                  text: bill.paid ? 'PAID ${bill.paidDate}' : 'DUE ${bill.dueDate.toUpperCase()}',
                  color: bill.paid ? c.success : const Color(0xFF92600F),
                  tint: bill.paid ? c.successTint : c.amberTint,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                _row(c, bill.title, bill.amount * 0.7),
                _row(c, 'Security Fund', bill.amount * 0.18),
                _row(c, 'Street Lighting', bill.amount * 0.12),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(color: c.primaryTint, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Due', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: c.maroon)),
                      Text('PKR ${bill.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: c.maroon)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (!bill.paid) PrimaryButton(label: 'PAY NOW · PKR ${bill.amount.toStringAsFixed(0)}', onTap: () => s.nav(AppScreen.payMethod)),
        ],
      ),
    );
  }

  Widget _row(AppColors c, String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: c.mid)),
          Text(amount.toStringAsFixed(0), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
        ],
      ),
    );
  }
}

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final bill = mockBills.firstWhere((b) => !b.paid, orElse: () => mockBills.first);

    final methods = [
      (icon: Icons.account_balance_wallet, label: 'JazzCash', sub: 'Mobile wallet · last used', color: const Color(0xFFC8102E)),
      (icon: Icons.account_balance_wallet_outlined, label: 'Easypaisa', sub: 'Mobile wallet', color: const Color(0xFF00A651)),
      (icon: Icons.credit_card, label: 'Credit / Debit Card', sub: 'Visa, Mastercard', color: c.slate),
      (icon: Icons.account_balance, label: 'Bank Transfer', sub: 'Direct IBFT', color: c.mid),
    ];

    return SubScreen(
      title: 'Select Payment',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 13.5, color: c.mid),
              children: [
                const TextSpan(text: 'Paying '),
                TextSpan(text: 'PKR ${bill.amount.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.w700, color: c.ink)),
                TextSpan(text: ' for ${bill.period}'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(methods.length, (i) {
            final m = methods[i];
            final active = _selected == i;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: c.surface,
                    border: Border.all(color: active ? s.accent.accent : c.border, width: active ? 1.6 : 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(color: m.color.withOpacity(0.14), borderRadius: BorderRadius.circular(12)),
                        child: Icon(m.icon, color: m.color, size: 21),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.label, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                            const SizedBox(height: 2),
                            Text(m.sub, style: TextStyle(fontSize: 11.5, color: c.light)),
                          ],
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: active ? s.accent.accent : c.border, width: 1.6),
                          color: active ? s.accent.accent : Colors.transparent,
                        ),
                        child: active ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 10),
          PrimaryButton(label: 'CONTINUE TO PAY', onTap: () => s.nav(AppScreen.paySuccess)),
        ],
      ),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final bill = mockBills.firstWhere((b) => !b.paid, orElse: () => mockBills.first);

    return AppScaffold(
      bleedTop: true,
      backgroundColor: const Color(0xFF3F6B50),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF3F6B50), Color(0xFF5C8A6A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        padding: EdgeInsets.fromLTRB(26, topInset(context) + 60, 26, 30),
        child: Column(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.check, size: 44, color: Color(0xFF3F6B50)),
            ),
            const SizedBox(height: 22),
            const Text('Payment Successful!', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 6),
            Text('${bill.period} charges are cleared', style: const TextStyle(fontSize: 13.5, color: Colors.white70)),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.14), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  _detailRow('Amount', 'PKR ${bill.amount.toStringAsFixed(0)}'),
                  const SizedBox(height: 10),
                  _detailRow('Reference', 'JC-8841920'),
                  const SizedBox(height: 10),
                  _detailRow('Date', '30 Jun 2026, 9:41 AM'),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download_outlined, size: 18, color: Color(0xFF3F6B50)),
                  SizedBox(width: 8),
                  Text('Download Receipt', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF3F6B50))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => s.tabNav(AppTab.home),
              child: const Text('Back to Home', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12.5, color: Colors.white70)),
        Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}
