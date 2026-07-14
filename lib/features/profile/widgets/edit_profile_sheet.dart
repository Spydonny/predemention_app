import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/providers/assistant_provider.dart';
import '../../../l10n/generated/app_localizations.dart';

void showEditProfileSheet(BuildContext context, WidgetRef ref) {
  final assistant = ref.read(assistantProvider);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.palette.paper,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (sheetContext) => _EditProfileForm(
      initialPhone: assistant.phone,
      initialEmail: assistant.email,
      initialCity: assistant.city,
      onSave: (phone, email, city) {
        ref.read(assistantProfileProvider.notifier).updateContact(phone: phone, email: email, city: city);
        Navigator.pop(sheetContext);
      },
    ),
  );
}

class _EditProfileForm extends StatefulWidget {
  final String initialPhone;
  final String initialEmail;
  final String initialCity;
  final void Function(String phone, String email, String city) onSave;

  const _EditProfileForm({
    required this.initialPhone,
    required this.initialEmail,
    required this.initialCity,
    required this.onSave,
  });

  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.initialPhone);
    _emailController = TextEditingController(text: widget.initialEmail);
    _cityController = TextEditingController(text: widget.initialCity);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.editProfileSheetTitle, style: AppTheme.display(fontSize: 19, fontWeight: FontWeight.w600, color: palette.textPrimary)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: l10n.fieldPhone),
                  validator: (v) => (v == null || v.trim().isEmpty) ? l10n.fieldPhone : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: l10n.fieldEmail),
                  validator: (v) => (v == null || !v.contains('@')) ? l10n.fieldEmail : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: l10n.fieldCity),
                  validator: (v) => (v == null || v.trim().isEmpty) ? l10n.fieldCity : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n.cancelButton),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.onSave(_phoneController.text.trim(), _emailController.text.trim(), _cityController.text.trim());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.paper,
                        ),
                        child: Text(l10n.saveButton),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
