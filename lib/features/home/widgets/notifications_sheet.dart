import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/models/visit_model.dart';
import '../../../l10n/generated/app_localizations.dart';

void showNotificationsSheet(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context)!;
  final settings = ref.read(settingsControllerProvider);
  final visits = ref.read(todayVisitsProvider);

  final lines = <String>[];
  for (final v in visits) {
    switch (v.status) {
      case VisitStatus.scheduled:
      case VisitStatus.inTransit:
        lines.add(l10n.notificationVisitScheduled(v.patient.fullName, DateFormat('HH:mm').format(v.scheduledTime)));
      case VisitStatus.inProgress:
      case VisitStatus.arriving:
        lines.add(l10n.notificationVisitInProgress(v.patient.fullName));
      case VisitStatus.completed:
        lines.add(l10n.notificationVisitCompleted(v.patient.fullName));
      case VisitStatus.cancelled:
        break;
    }
  }

  showModalBottomSheet(
    context: context,
    backgroundColor: context.palette.paper,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (sheetContext) {
      final palette = sheetContext.palette;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.notificationsSheetTitle, style: AppTheme.display(fontSize: 19, fontWeight: FontWeight.w600, color: palette.textPrimary)),
              const SizedBox(height: 16),
              if (!settings.notificationsEnabled)
                _EmptyRow(
                  icon: Icons.notifications_off_outlined,
                  text: l10n.notificationsDisabledState,
                  actionLabel: l10n.notificationsDisabledAction,
                  onAction: () {
                    Navigator.pop(sheetContext);
                    context.push('/settings');
                  },
                )
              else if (lines.isEmpty)
                _EmptyRow(icon: Icons.notifications_none_rounded, text: l10n.notificationsEmptyState)
              else
                ...lines.map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 6, color: palette.primary),
                          const SizedBox(width: 10),
                          Expanded(child: Text(line, style: TextStyle(fontSize: 14, color: palette.textPrimary, height: 1.4))),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      );
    },
  );
}

class _EmptyRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _EmptyRow({required this.icon, required this.text, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Icon(icon, size: 32, color: palette.textTertiary),
          const SizedBox(height: 10),
          Text(text, style: TextStyle(fontSize: 14, color: palette.textSecondary), textAlign: TextAlign.center),
          if (actionLabel != null) ...[
            const SizedBox(height: 12),
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
