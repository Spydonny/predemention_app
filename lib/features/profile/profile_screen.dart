import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/providers/app_providers.dart';
import '../../core/models/device_model.dart';
import '../../l10n/generated/app_localizations.dart';
import 'widgets/edit_profile_sheet.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final assistant = ref.watch(assistantProvider);

    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: palette.surface,
              surfaceTintColor: Colors.transparent,
              title: Text(l10n.profileScreenTitle),
              actions: [
                IconButton(icon: const Icon(Icons.edit_rounded), onPressed: () => showEditProfileSheet(context, ref)),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Avatar
                    Center(
                      child: Column(
                        children: [
                          Hero(
                            tag: 'profile_avatar',
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [BoxShadow(color: AppColors.primary.withAlpha(40), blurRadius: 20, offset: const Offset(0, 8))],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                assistant.initials,
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.paper),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(assistant.fullName, style: AppTheme.display(fontSize: 24, fontWeight: FontWeight.w600, color: palette.textPrimary, letterSpacing: -0.4)),
                          const SizedBox(height: 4),
                          Text(assistant.role, style: TextStyle(fontSize: 14, color: palette.textSecondary)),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star_rounded, size: 16, color: palette.warning),
                              const SizedBox(width: 4),
                              Text(
                                '${assistant.rating} • ${assistant.city}',
                                style: TextStyle(fontSize: 13, color: palette.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Stats grid
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            icon: Icons.calendar_month_rounded,
                            value: '${assistant.totalVisits}',
                            label: l10n.statTotalVisits,
                            color: palette.info,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            icon: Icons.today_rounded,
                            value: '${assistant.assessmentsThisMonth}',
                            label: l10n.statThisMonth,
                            color: palette.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            icon: Icons.timer_rounded,
                            value: assistant.averageAssessmentTime.toStringAsFixed(0),
                            unit: l10n.unitMinutes,
                            label: l10n.statAvgTime,
                            color: palette.warning,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            icon: Icons.devices_rounded,
                            value: '${DeviceModel.mockDevices.length}',
                            label: l10n.statDevices,
                            color: palette.secondaryInk,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Info card
                    SectionHeader(title: l10n.sectionContactInfo),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: palette.paper,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: palette.border.withAlpha(100)),
                      ),
                      child: Column(
                        children: [
                          _InfoRow(icon: Icons.email_rounded, label: l10n.fieldEmail, value: assistant.email),
                          const Divider(height: 24),
                          _InfoRow(icon: Icons.call_rounded, label: l10n.fieldPhone, value: assistant.phone),
                          const Divider(height: 24),
                          _InfoRow(icon: Icons.location_city_rounded, label: l10n.fieldCity, value: assistant.city),
                          const Divider(height: 24),
                          _InfoRow(icon: Icons.badge_rounded, label: l10n.fieldRole, value: assistant.role),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Certifications
                    SectionHeader(title: l10n.sectionCertifications),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: palette.paper,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: palette.border.withAlpha(100)),
                      ),
                      child: const Column(
                        children: [
                          _CertItem(title: 'PreDemention Certified Specialist', date: 'Level 3 • Действует до 03.2025'),
                          Divider(height: 24),
                          _CertItem(title: 'Gait Analysis Professional', date: 'Level 2 • Действует до 06.2025'),
                          Divider(height: 24),
                          _CertItem(title: 'Medical Device Operator', date: 'Сертификат № KZ-2024-0843'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
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
              _navItem(context, Icons.history_rounded, l10n.navHistory, false, () => context.go('/history')),
              _navItem(context, Icons.person_rounded, l10n.navProfile, true, () {}),
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String? unit;
  final String label;
  final Color color;

  const _StatCard({required this.icon, required this.value, this.unit, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(128)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: AppTheme.figure(fontSize: 24, fontWeight: FontWeight.w600, color: palette.textPrimary)),
              if (unit != null) ...[
                const SizedBox(width: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(unit!, style: TextStyle(fontSize: 11, color: palette.textTertiary)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: palette.textSecondary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: palette.surfaceVariant, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 16, color: palette.textSecondary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: palette.textTertiary)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: palette.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}

class _CertItem extends StatelessWidget {
  final String title;
  final String date;

  const _CertItem({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: palette.success.withAlpha(20), borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.verified_rounded, size: 16, color: palette.success),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: palette.textPrimary)),
              const SizedBox(height: 2),
              Text(date, style: TextStyle(fontSize: 12, color: palette.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
