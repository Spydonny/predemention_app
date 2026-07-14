import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/providers/app_providers.dart';
import '../../core/models/visit_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../home/widgets/visit_mini_card.dart';

class VisitsScreen extends ConsumerStatefulWidget {
  const VisitsScreen({super.key});

  @override
  ConsumerState<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends ConsumerState<VisitsScreen> {
  String _searchQuery = '';
  VisitStatus? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    final allVisits = ref.watch(allVisitsProvider);

    var filtered = allVisits.where((v) {
      if (_statusFilter != null && v.status != _statusFilter) return false;
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return v.patient.fullName.toLowerCase().contains(q) ||
            v.patient.city.toLowerCase().contains(q);
      }
      return true;
    }).toList();

    filtered.sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));

    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: palette.surface,
              surfaceTintColor: Colors.transparent,
              title: Text(l10n.visitsScreenTitle),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Column(
                    children: [
                      // Search
                      TextField(
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: l10n.searchHintNameOrCity,
                          prefixIcon: Icon(Icons.search_rounded, color: palette.textTertiary),
                          suffixIcon: Icon(Icons.filter_list_rounded, color: palette.textTertiary),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Filters
                      SizedBox(
                        height: 36,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _FilterChip(
                              label: l10n.filterAll,
                              selected: _statusFilter == null,
                              onTap: () => setState(() => _statusFilter = null),
                            ),
                            ...VisitStatus.values.map((s) => _FilterChip(
                                  label: s.label(context),
                                  color: s.color,
                                  selected: _statusFilter == s,
                                  onTap: () => setState(() => _statusFilter = s),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final visit = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: VisitMiniCard(
                        visit: visit,
                        onTap: () => context.push('/visit/${visit.id}'),
                      ),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, l10n),
    );
  }

  Widget _buildBottomNav(BuildContext context, AppLocalizations l10n) {
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: palette.paper,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(context, Icons.home_rounded, l10n.navHome, false, () => context.go('/home')),
              _navItem(context, Icons.calendar_month_rounded, l10n.navVisits, true, () {}),
              _navItem(context, Icons.history_rounded, l10n.navHistory, false, () => context.go('/history')),
              _navItem(context, Icons.person_rounded, l10n.navProfile, false, () => context.go('/profile')),
              _navItem(context, Icons.settings_rounded, l10n.navSettings, false, () => context.go('/settings')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, bool sel, VoidCallback tap) {
    final palette = context.palette;
    return GestureDetector(
      onTap: tap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? palette.primary.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: sel ? palette.primary : palette.textTertiary),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: sel ? FontWeight.w600 : FontWeight.w500, color: sel ? palette.primary : palette.textTertiary)),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final Color? color;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, this.color, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? (color ?? palette.primary) : palette.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? palette.paper : palette.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
