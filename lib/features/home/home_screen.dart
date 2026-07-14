import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/models/visit_model.dart';
import '../../l10n/generated/app_localizations.dart';
import 'widgets/home_map.dart';
import 'widgets/visit_mini_card.dart';
import 'widgets/stats_row.dart';
import 'widgets/notifications_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final todayVisits = ref.watch(todayVisitsProvider);
    final assistant = ref.watch(assistantProvider);
    final darkMap = ref.watch(settingsControllerProvider).darkMap;

    final activeVisit = todayVisits.where(
      (v) => v.status == VisitStatus.inProgress || v.status == VisitStatus.arriving,
    ).firstOrNull;

    final nextVisit = todayVisits.where(
      (v) => v.status == VisitStatus.scheduled || v.status == VisitStatus.inTransit,
    ).firstOrNull;

    final completedToday = todayVisits.where((v) => v.status == VisitStatus.completed).length;
    final totalToday = todayVisits.length;

    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const _Header(),
            // Map
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.34,
              child: HomeMap(visits: todayVisits, darkMap: darkMap),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats
                    StatsRow(
                      completedToday: completedToday,
                      totalToday: totalToday,
                      totalAll: assistant.totalVisits,
                      rating: assistant.rating,
                    ),
                    const SizedBox(height: 24),

                    // Active assessment
                    if (activeVisit != null) ...[
                      SectionHeader(title: l10n.sectionCurrentAssessment),
                      const SizedBox(height: 12),
                      _ActiveAssessmentCard(
                        visit: activeVisit,
                        onTap: () => context.push('/assessment/${activeVisit.id}'),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Next visit
                    if (nextVisit != null) ...[
                      SectionHeader(title: l10n.sectionNextVisit),
                      const SizedBox(height: 12),
                      VisitMiniCard(
                        visit: nextVisit,
                        onTap: () => context.push('/visit/${nextVisit.id}'),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Today's visits
                    SectionHeader(title: l10n.sectionTodayVisits),
                    const SizedBox(height: 12),
                    ...todayVisits.map((v) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: VisitMiniCard(
                            visit: v,
                            onTap: () => context.push('/visit/${v.id}'),
                          ),
                        )),

                    const SizedBox(height: 24),

                    // Quick actions
                    SectionHeader(title: l10n.sectionQuickActions),
                    const SizedBox(height: 12),
                    _QuickActions(onAction: (route) => context.push(route)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, l10n),
    );
  }

  Widget _buildBottomNav(BuildContext context, AppLocalizations l10n) {
    final location = GoRouterState.of(context).uri.toString();
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: palette.paper,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: l10n.navHome,
                isSelected: location == '/home',
                onTap: () => context.go('/home'),
              ),
              _NavItem(
                icon: Icons.calendar_month_rounded,
                label: l10n.navVisits,
                isSelected: location.startsWith('/visit'),
                onTap: () => context.go('/visits'),
              ),
              _NavItem(
                icon: Icons.history_rounded,
                label: l10n.navHistory,
                isSelected: location == '/history',
                onTap: () => context.go('/history'),
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: l10n.navProfile,
                isSelected: location == '/profile',
                onTap: () => context.go('/profile'),
              ),
              _NavItem(
                icon: Icons.settings_rounded,
                label: l10n.navSettings,
                isSelected: location == '/settings',
                onTap: () => context.go('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 6) return l10n.greetingNight;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 18) return l10n.greetingDay;
    return l10n.greetingEvening;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final assistant = ref.watch(assistantProvider);
    final hasUnread = ref.watch(homeUnreadNotificationsProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.psychology_rounded, color: AppColors.paper, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'predemention',
                  style: AppTheme.display(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: palette.textPrimary,
                    letterSpacing: -0.6,
                  ),
                ),
                Text(
                  '${_greeting(l10n)}, ${assistant.fullName.split(' ')[0]}',
                  style: TextStyle(
                    fontSize: 13,
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  ref.read(homeUnreadNotificationsProvider.notifier).state = false;
                  showNotificationsSheet(context, ref);
                },
                icon: Icon(Icons.notifications_outlined, color: palette.textPrimary),
              ),
              if (hasUnread)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: palette.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveAssessmentCard extends StatelessWidget {
  final VisitModel visit;
  final VoidCallback onTap;

  const _ActiveAssessmentCard({required this.visit, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withAlpha(30),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const PulseDot(color: AppColors.paper),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.assessmentInProgressLabel,
                    style: const TextStyle(
                      color: AppColors.paper,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    visit.patient.fullName,
                    style: TextStyle(
                      color: AppColors.paper.withAlpha(200),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.paper, size: 18),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final void Function(String route) onAction;

  const _QuickActions({required this.onAction});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final actions = [
      (l10n.quickActionNewVisit, Icons.add_location_rounded, '/visits'),
      (l10n.quickActionReports, Icons.description_rounded, '/history'),
      (l10n.quickActionDevices, Icons.bluetooth_rounded, '/visits'),
    ];

    return Row(
      children: actions.map((a) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: a == actions.first ? 0 : 8,
              right: a == actions.last ? 0 : 8,
            ),
            child: GestureDetector(
              onTap: () => onAction(a.$3),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: palette.paper,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: palette.border.withAlpha(128)),
                ),
                child: Column(
                  children: [
                    Icon(a.$2, color: palette.primary, size: 22),
                    const SizedBox(height: 8),
                    Text(
                      a.$1,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: palette.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? palette.primary.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? palette.primary : palette.textTertiary,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? palette.primary : palette.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
