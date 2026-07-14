import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/models/app_settings.dart';
import '../../core/providers/settings_provider.dart';
import '../../l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Purely synthetic display data for the demo cache — not real storage, so
  // it doesn't need persistence, just an honest "clear" interaction.
  double _cacheSizeMb = 128.5;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

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
              title: Text(l10n.settingsScreenTitle),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Appearance
                    SectionHeader(title: l10n.sectionAppearance),
                    const SizedBox(height: 12),
                    _SettingsGroup(
                      children: [
                        _Tile(
                          icon: Icons.brightness_6_rounded,
                          iconColor: palette.warning,
                          title: l10n.themeTileTitle,
                          subtitle: _themeLabel(l10n, settings.themeMode),
                          trailing: Icon(Icons.chevron_right_rounded, color: palette.textTertiary, size: 20),
                          onTap: () => _showThemePicker(context, ref),
                        ),
                        const _Divider(),
                        _Tile(
                          icon: Icons.language_rounded,
                          iconColor: palette.info,
                          title: l10n.languageTileTitle,
                          subtitle: _languageLabel(settings.languageCode),
                          trailing: Icon(Icons.chevron_right_rounded, color: palette.textTertiary, size: 20),
                          onTap: () => _showLanguagePicker(context, ref),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Notifications
                    SectionHeader(title: l10n.sectionNotificationsHeader),
                    const SizedBox(height: 12),
                    _SettingsGroup(
                      children: [
                        _SwitchTile(
                          icon: Icons.notifications_active_rounded,
                          iconColor: palette.error,
                          title: l10n.pushNotificationsTitle,
                          subtitle: l10n.pushNotificationsSubtitle,
                          value: settings.notificationsEnabled,
                          onChanged: controller.setNotificationsEnabled,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Data
                    SectionHeader(title: l10n.sectionData),
                    const SizedBox(height: 12),
                    _SettingsGroup(
                      children: [
                        _SwitchTile(
                          icon: Icons.sync_rounded,
                          iconColor: palette.success,
                          title: l10n.autoSyncTitle,
                          subtitle: l10n.autoSyncSubtitle,
                          value: settings.autoSync,
                          onChanged: controller.setAutoSync,
                        ),
                        const _Divider(),
                        _Tile(
                          icon: Icons.cloud_download_rounded,
                          iconColor: palette.info,
                          title: l10n.cacheTitle,
                          subtitle: '${_cacheSizeMb.toStringAsFixed(1)} MB',
                          trailing: TextButton(
                            onPressed: () => _confirmClearCache(context, l10n),
                            child: Text(l10n.clearCacheButton, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.primary)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Map
                    SectionHeader(title: l10n.sectionMap),
                    const SizedBox(height: 12),
                    _SettingsGroup(
                      children: [
                        _SwitchTile(
                          icon: Icons.map_rounded,
                          iconColor: palette.secondaryInk,
                          title: l10n.darkMapTitle,
                          subtitle: l10n.darkMapSubtitle,
                          value: settings.darkMap,
                          onChanged: controller.setDarkMap,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // About
                    SectionHeader(title: l10n.sectionAbout),
                    const SizedBox(height: 12),
                    _SettingsGroup(
                      children: [
                        _Tile(
                          icon: Icons.info_outline_rounded,
                          iconColor: palette.textSecondary,
                          title: l10n.versionTitle,
                          subtitle: '1.0.0 (build 42)',
                        ),
                        const _Divider(),
                        _Tile(
                          icon: Icons.article_outlined,
                          iconColor: palette.textSecondary,
                          title: l10n.licenseTileTitle,
                          trailing: Icon(Icons.chevron_right_rounded, color: palette.textTertiary, size: 20),
                          onTap: () => context.push('/settings/license'),
                        ),
                        const _Divider(),
                        _Tile(
                          icon: Icons.privacy_tip_outlined,
                          iconColor: palette.textSecondary,
                          title: l10n.privacyTileTitle,
                          trailing: Icon(Icons.chevron_right_rounded, color: palette.textTertiary, size: 20),
                          onTap: () => context.push('/settings/privacy'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Footer
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.psychology_rounded, color: AppColors.primary, size: 28),
                          ),
                          const SizedBox(height: 12),
                          const Text('predemention', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
                          const SizedBox(height: 4),
                          Text(l10n.appTagline, style: TextStyle(fontSize: 12, color: palette.textTertiary)),
                          const SizedBox(height: 4),
                          Text(l10n.footerCopyright, style: TextStyle(fontSize: 11, color: palette.textTertiary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
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

  String _themeLabel(AppLocalizations l10n, AppThemeMode mode) => switch (mode) {
        AppThemeMode.light => l10n.themeLight,
        AppThemeMode.dark => l10n.themeDark,
        AppThemeMode.system => l10n.themeSystem,
      };

  String _languageLabel(String code) => switch (code) {
        'en' => 'English',
        'kk' => 'Қазақша',
        _ => 'Русский',
      };

  Future<void> _confirmClearCache(BuildContext context, AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.clearCacheDialogTitle),
        content: Text(l10n.clearCacheDialogBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(l10n.cancelButton)),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text(l10n.clearCacheConfirm)),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _cacheSizeMb = 0);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.clearCacheSnackbar)));
  }

  void _showThemePicker(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.read(settingsControllerProvider).themeMode;
    showModalBottomSheet(
      context: context,
      backgroundColor: context.palette.paper,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppThemeMode.values.map((mode) => ListTile(
                title: Text(_themeLabel(l10n, mode)),
                trailing: current == mode ? Icon(Icons.check_rounded, color: sheetContext.palette.primary) : null,
                onTap: () {
                  ref.read(settingsControllerProvider.notifier).setThemeMode(mode);
                  Navigator.pop(sheetContext);
                },
              )).toList(),
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(settingsControllerProvider).languageCode;
    const options = [('ru', 'Русский'), ('en', 'English'), ('kk', 'Қазақша')];
    showModalBottomSheet(
      context: context,
      backgroundColor: context.palette.paper,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((o) => ListTile(
                title: Text(o.$2),
                trailing: current == o.$1 ? Icon(Icons.check_rounded, color: sheetContext.palette.primary) : null,
                onTap: () {
                  ref.read(settingsControllerProvider.notifier).setLanguageCode(o.$1);
                  Navigator.pop(sheetContext);
                },
              )).toList(),
        ),
      ),
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
              _navItem(context, Icons.person_rounded, l10n.navProfile, false, () => context.go('/profile')),
              _navItem(context, Icons.settings_rounded, l10n.navSettings, true, () {}),
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

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(100)),
      ),
      child: Column(children: children),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _Tile({required this.icon, required this.iconColor, required this.title, this.subtitle, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: iconColor.withAlpha(20), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: palette.textPrimary)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: TextStyle(fontSize: 12, color: palette.textSecondary)),
                  ],
                ],
              ),
            ),
            if (trailing case final t?) t,
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({required this.icon, required this.iconColor, required this.title, required this.subtitle, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor.withAlpha(20), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: palette.textPrimary)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 12, color: palette.textSecondary)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, indent: 60, color: context.palette.divider);
  }
}
