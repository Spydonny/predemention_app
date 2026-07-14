import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/providers/app_providers.dart';
import '../../core/models/visit_model.dart';
import '../../l10n/generated/app_localizations.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _searchQuery = '';

  List<VisitModel> _filteredVisits(List<VisitModel> visits) {
    final completed = visits.where((v) => v.status == VisitStatus.completed).toList();
    completed.sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
    if (_searchQuery.isEmpty) return completed;
    final q = _searchQuery.toLowerCase();
    return completed.where((v) => v.patient.fullName.toLowerCase().contains(q) || v.patient.city.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final locale = Localizations.localeOf(context).languageCode;
    final visits = _filteredVisits(ref.watch(allVisitsProvider));

    // Group by date
    final grouped = <String, List<VisitModel>>{};
    for (final v in visits) {
      final dateKey = DateFormat('dd MMMM yyyy', locale).format(v.scheduledTime);
      grouped.putIfAbsent(dateKey, () => []).add(v);
    }

    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: palette.surface,
              surfaceTintColor: Colors.transparent,
              title: Text(l10n.historyScreenTitle),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText: l10n.searchHintNameOrCity,
                      prefixIcon: Icon(Icons.search_rounded, color: palette.textTertiary),
                    ),
                  ),
                ),
              ),
            ),
            if (visits.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.history_rounded, size: 64, color: palette.textTertiary),
                      const SizedBox(height: 12),
                      Text(l10n.emptyStateNoCompletedAssessments, style: TextStyle(fontSize: 16, color: palette.textSecondary)),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final entry = grouped.entries.elementAt(index);
                      return _DateGroup(
                        date: entry.key,
                        visits: entry.value,
                        onVisitTap: (v) {
                          if (v.assessmentId != null) {
                            context.push('/report/${v.assessmentId}');
                          }
                        },
                      );
                    },
                    childCount: grouped.length,
                  ),
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(context, l10n),
    );
  }

  Widget _bottomNav(BuildContext context, AppLocalizations l10n) {
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(color: palette.paper, boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 20, offset: const Offset(0, -4))]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(context, Icons.home_rounded, l10n.navHome, false, () => context.go('/home')),
              _navItem(context, Icons.calendar_month_rounded, l10n.navVisits, false, () => context.go('/visits')),
              _navItem(context, Icons.history_rounded, l10n.navHistory, true, () {}),
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
        decoration: BoxDecoration(color: sel ? palette.primary.withAlpha(20) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
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

class _DateGroup extends StatelessWidget {
  final String date;
  final List<VisitModel> visits;
  final void Function(VisitModel) onVisitTap;

  const _DateGroup({required this.date, required this.visits, required this.onVisitTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.calendar_today_rounded, color: AppColors.paper, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                date,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: palette.textPrimary),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: palette.surfaceVariant,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  l10n.assessmentsCountSuffix(visits.length),
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: palette.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Visit cards
          ...visits.asMap().entries.map((e) {
            final isLast = e.key == visits.length - 1;
            return Padding(
              padding: const EdgeInsets.only(left: 18),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline line + dot
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: palette.success,
                            shape: BoxShape.circle,
                            border: Border.all(color: palette.paper, width: 2),
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: palette.border,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    // Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                        child: _HistoryCard(visit: e.value, onTap: () => onVisitTap(e.value)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final VisitModel visit;
  final VoidCallback onTap;

  const _HistoryCard({required this.visit, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final locale = Localizations.localeOf(context).languageCode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: palette.paper,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: palette.border.withAlpha(100)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(15),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                visit.patient.initials,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(visit.patient.fullName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: palette.textPrimary)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 12, color: palette.textTertiary),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('HH:mm', locale).format(visit.scheduledTime),
                        style: TextStyle(fontSize: 11, color: palette.textSecondary),
                      ),
                      if (visit.actualEndTime != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '• ${l10n.durationMinutesSuffix(visit.actualEndTime!.difference(visit.actualStartTime ?? visit.scheduledTime).inMinutes)}',
                          style: TextStyle(fontSize: 11, color: palette.textSecondary),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: palette.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }
}
