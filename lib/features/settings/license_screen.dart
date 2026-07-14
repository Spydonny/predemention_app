import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../l10n/generated/app_localizations.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    return AppScaffold(
      title: l10n.licenseScreenTitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(
          l10n.licenseBody,
          style: TextStyle(fontSize: 14, height: 1.6, color: palette.textPrimary),
        ),
      ),
    );
  }
}
