import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../models/app_screen.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/common.dart';

String _comFilterLabel(ComFilter f) {
  switch (f) {
    case ComFilter.top:
      return 'Top';
    case ComFilter.help:
      return 'Help';
    case ComFilter.announcement:
      return 'Announcement';
    case ComFilter.entertainment:
      return 'Entertainment';
    case ComFilter.recent:
      return 'Recent';
  }
}

String _mktFilterLabel(MktFilter f) {
  switch (f) {
    case MktFilter.all:
      return 'All';
    case MktFilter.furniture:
      return 'Furniture';
    case MktFilter.electronics:
      return 'Electronics';
    case MktFilter.mechanical:
      return 'Mechanical';
    case MktFilter.home:
      return 'Home';
  }
}

Color _categoryColor(AppColors c, String category) {
  switch (category) {
    case 'Lost & Found':
      return c.amber;
    case 'Alert':
      return c.danger;
    case 'Event':
      return c.success;
    default:
      return c.primary;
  }
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final isSocial = s.comTab == ComTab.social;

    return AppScaffold(
      scrollable: false,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: kScreenPadTop,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Community', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: s.colors.ink)),
                      const SizedBox(height: 16),
                      SegmentedTabs(
                        labels: const ['Social Feed', 'Marketplace'],
                        activeIndex: s.comTab.index,
                        onChanged: (i) => s.setComTab(ComTab.values[i]),
                      ),
                      const SizedBox(height: 16),
                      if (isSocial) const _SocialFeed() else const _Marketplace(),
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
              onTap: () => s.nav(isSocial ? AppScreen.composePost : AppScreen.listProduct),
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: s.colors.shadow, blurRadius: 16, offset: const Offset(0, 6))],
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

class _SocialFeed extends StatelessWidget {
  const _SocialFeed();

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final filtered = s.comFilter == ComFilter.top
        ? mockPosts
        : s.comFilter == ComFilter.help
            ? mockPosts.where((p) => p.category == 'Lost & Found').toList()
            : s.comFilter == ComFilter.announcement
                ? mockPosts.where((p) => p.category == 'Alert').toList()
                : s.comFilter == ComFilter.entertainment
                    ? mockPosts.where((p) => p.category == 'Event').toList()
                    : mockPosts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ComFilter.values
                .map((f) => FilterChip2(label: _comFilterLabel(f), active: s.comFilter == f, onTap: () => s.setComFilter(f)))
                .toList(),
          ),
        ),
        const SizedBox(height: 14),
        ...filtered.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InitialsAvatar(initials: p.initials, size: 38, bg: s.accent.accent.withOpacity(0.15), fg: s.accent.accent),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.author, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                              Text(p.time, style: TextStyle(fontSize: 11, color: c.light)),
                            ],
                          ),
                        ),
                        StatusPill(text: p.category, color: _categoryColor(c, p.category), tint: _categoryColor(c, p.category).withOpacity(0.14)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(p.body, style: TextStyle(fontSize: 13, color: c.mid, height: 1.5)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.favorite_border, size: 16, color: c.light),
                        const SizedBox(width: 5),
                        Text('${p.likes}', style: TextStyle(fontSize: 12, color: c.light)),
                        const SizedBox(width: 16),
                        Icon(Icons.chat_bubble_outline, size: 15, color: c.light),
                        const SizedBox(width: 5),
                        Text('${p.comments}', style: TextStyle(fontSize: 12, color: c.light)),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

class _Marketplace extends StatelessWidget {
  const _Marketplace();

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final filtered = s.mktFilter == MktFilter.all ? mockListings : mockListings.where((l) => l.category == _mktFilterLabel(s.mktFilter)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => s.nav(AppScreen.myAds),
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: c.primaryTint, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                Icon(Icons.storefront_outlined, color: c.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text('My Ads & Listings', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.maroon)),
                ),
                Icon(Icons.arrow_forward_ios, size: 13, color: c.maroon),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: MktFilter.values
                .map((f) => FilterChip2(label: _mktFilterLabel(f), active: s.mktFilter == f, onTap: () => s.setMktFilter(f)))
                .toList(),
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.78,
          children: filtered.map((l) {
            return GestureDetector(
              onTap: () => s.nav(AppScreen.listingDetail),
              child: Container(
                decoration: BoxDecoration(
                  color: c.surface,
                  border: Border.all(color: c.border, width: 1.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(8),
                      child: l.status != 'Active'
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.45), borderRadius: BorderRadius.circular(20)),
                              child: Text(l.status.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white)),
                            )
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.ink)),
                          const SizedBox(height: 5),
                          Text(l.price, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: s.accent.accent)),
                          const SizedBox(height: 3),
                          Text(l.time, style: TextStyle(fontSize: 10, color: c.light)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ComposePostScreen extends StatefulWidget {
  const ComposePostScreen({super.key});

  @override
  State<ComposePostScreen> createState() => _ComposePostScreenState();
}

class _ComposePostScreenState extends State<ComposePostScreen> {
  int _type = 0;
  static const _types = ['General', 'Lost & Found', 'Alert', 'Event'];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'New Post',
      trailing: GestureDetector(
        onTap: () => s.back(),
        child: Text('Post', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: s.accent.accent)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('Post Type'),
          const SizedBox(height: 9),
          Row(
            children: _types.asMap().entries.map((entry) {
              final active = _type == entry.key;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _type = entry.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    decoration: BoxDecoration(
                      color: active ? s.accent.accent : c.surface,
                      border: Border.all(color: active ? s.accent.accent : c.border),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(entry.value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : c.mid)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border, width: 1.5), borderRadius: BorderRadius.circular(12)),
            child: TextFormField(
              maxLines: 5,
              style: TextStyle(fontSize: 13.5, color: c.ink),
              decoration: InputDecoration(
                hintText: "What's happening in the society?",
                hintStyle: TextStyle(color: c.light, fontSize: 13.5),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(color: c.border, width: 1.4), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_outlined, color: c.light, size: 20),
                const SizedBox(width: 8),
                Text('Add photo', style: TextStyle(fontSize: 12.5, color: c.mid, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListingDetailScreen extends StatelessWidget {
  const ListingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;
    final Listing l = mockListings.first;

    return AppScaffold(
      bleedTop: true,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight)),
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
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.price, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: c.ink)),
                  const SizedBox(height: 6),
                  Text(l.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: c.ink)),
                  const SizedBox(height: 14),
                  Text(l.description, style: TextStyle(fontSize: 13.5, color: c.mid, height: 1.6)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _infoCard(c, 'Category', l.category)),
                      const SizedBox(width: 10),
                      Expanded(child: _infoCard(c, 'Posted', l.time)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  AppCard(
                    child: Row(
                      children: [
                        InitialsAvatar(initials: l.seller.split(' ').map((w) => w[0]).join(), size: 42, bg: s.accent.accent.withOpacity(0.15), fg: s.accent.accent),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l.seller, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: c.ink)),
                              Text('Seller', style: TextStyle(fontSize: 11.5, color: c.light)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  PrimaryButton(label: 'Chat with Seller', onTap: () => s.nav(AppScreen.chat)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(AppColors c, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10.5, color: c.light)),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
        ],
      ),
    );
  }
}

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  bool _showContact = false;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    return SubScreen(
      title: 'List an Item',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(color: c.border, width: 1.4), borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Icon(Icons.add_a_photo_outlined, color: c.light, size: 24),
                const SizedBox(height: 8),
                Text('Add photos', style: TextStyle(fontSize: 12.5, color: c.mid, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const FieldLabel('Title'),
          const AppField(hint: 'e.g. Dining Table (6-seater)'),
          const SizedBox(height: 14),
          const FieldLabel('Price (PKR)'),
          const AppField(hint: 'e.g. 35000', keyboardType: TextInputType.number),
          const SizedBox(height: 14),
          const FieldLabel('Category'),
          AppField(hint: 'Furniture', readOnly: true, prefix: Icon(Icons.arrow_drop_down, color: c.mid)),
          const SizedBox(height: 14),
          const FieldLabel('Description'),
          const AppField(hint: 'Describe the item, condition, etc.', maxLines: 4),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => setState(() => _showContact = !_showContact),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: _showContact ? s.accent.accent : c.border, width: 1.6),
                    color: _showContact ? s.accent.accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: _showContact ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
                ),
                const SizedBox(width: 10),
                Text('Show my contact number on listing', style: TextStyle(fontSize: 12.5, color: c.mid)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'POST LISTING', onTap: () => s.back()),
        ],
      ),
    );
  }
}

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final c = s.colors;

    final demo = [
      ('Dining Table (6-seater, wood)', 'Rs 35,000', 'Active', 'Listed 3h ago · 24 views'),
      ('iPhone 13, 128GB', 'Rs 145,000', 'Sold', 'Sold 1d ago'),
      ('Kids Bicycle (16-inch)', 'Rs 8,500', 'Expired', 'Expired · can relist'),
      ('Old Sofa Set', 'Rs 12,000', 'Expired', 'Expired · relist limit reached'),
    ];

    return AppScaffold(
      scrollable: false,
      body: Stack(
        children: [
          Column(
            children: [
              DetailHeader(title: 'My Ads & Listings'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: _statBox(c, '2', 'Active')),
                          const SizedBox(width: 10),
                          Expanded(child: _statBox(c, '1', 'Sold')),
                          const SizedBox(width: 10),
                          Expanded(child: _statBox(c, '2', 'Expired')),
                        ],
                      ),
                      const SizedBox(height: 18),
                      ...demo.map((d) {
                        final relistable = d.$3 == 'Expired' && d.$4.contains('can relist');
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Opacity(
                            opacity: d.$3 == 'Active' ? 1 : 0.75,
                            child: AppCard(
                              child: Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: d.$3 == 'Active' ? c.success : (d.$3 == 'Sold' ? c.slate : c.light),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(d.$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c.ink)),
                                        const SizedBox(height: 3),
                                        Text('${d.$2} · ${d.$4}', style: TextStyle(fontSize: 11, color: c.light)),
                                      ],
                                    ),
                                  ),
                                  if (relistable)
                                    Text('Relist', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: s.accent.accent))
                                  else
                                    StatusPill(
                                      text: d.$3.toUpperCase(),
                                      color: d.$3 == 'Active' ? c.success : (d.$3 == 'Sold' ? c.slate : c.light),
                                      tint: (d.$3 == 'Active' ? c.success : (d.$3 == 'Sold' ? c.slate : c.light)).withOpacity(0.14),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
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
              onTap: () => s.nav(AppScreen.listProduct),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: s.accent.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: c.shadow, blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text('Add listing', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBox(AppColors c, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: c.surface, border: Border.all(color: c.border), borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.ink)),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(fontSize: 10.5, color: c.light)),
        ],
      ),
    );
  }
}
