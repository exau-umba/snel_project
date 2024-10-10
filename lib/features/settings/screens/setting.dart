import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:snel_project/utils/Routes.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/components/components.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool notification = false;
  bool use_fingerprint = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: KcolorPrimary.withOpacity(1.5.sp),
      appBar: AppBar(
        centerTitle: true,
        title: text("Setting", fontSize: 20.sp, textColor: KColorWhite),
        backgroundColor: KcolorPrimary,
      ),
      body: _body(),
    );
  }

  _body() {
    return SettingsList(
        shrinkWrap: true,
        platform: DevicePlatform.iOS,
        sections: [
      SettingsSection(title: Text("Account"), tiles: [
        SettingsTile(
          title: text("Email",fontSize: 17.5.sp, textColor: t12_text_color_primary),
          leading: Icon(Icons.email_outlined),
          trailing: Icon(Icons.arrow_forward_ios),
          onPressed: (BuildContext context) {},
        ),
        SettingsTile(
          title: text("Déconnexion",fontSize: 17.5.sp, textColor: t12_text_color_primary),
          leading: Icon(Icons.logout_outlined),
          trailing: Icon(Icons.arrow_forward_ios),
          onPressed: (BuildContext context) {},
        ),
      ]),
      SettingsSection(
          title: Text("Account"), tiles: [
        SettingsTile(
          title: text('Language', fontSize: 17.5.sp, textColor: t12_text_color_primary),
          description: Text('Français'),
          leading: Icon(Icons.language),
          onPressed: (BuildContext context) {},
        ),
        SettingsTile.switchTile(
            title: text('Notification',fontSize: 17.5.sp, textColor: t12_text_color_primary),
          leading: Icon(Icons.notifications_active_outlined),
          initialValue: notification,
          activeSwitchColor: KcolorPrimary,
          onToggle: (bool value) {
              notification = value;
              setState(() {

              });
        },
        )
      ]),
      SettingsSection(
        title: Text("Paiement"),
          tiles: [
            SettingsTile(
                title: text("Mode de paiement",fontSize: 17.5.sp, textColor: t12_text_color_primary),
              description: text("Voir et ajouter un mode de paiment", fontSize: 15.sp),
              leading: Icon(Icons.payment),
              trailing: Icon(Icons.arrow_forward_ios),
              onPressed: (context) {
                Navigator.pushNamed(context, Routes.modePayment);
              },
            )
          ]
      ),
      SettingsSection(title: Text("Sécurité"), tiles: [
        SettingsTile(
          title: text('Changer le mot de passe', fontSize: 17.5.sp,
              textColor: t12_text_color_primary),
          description: text("Modifier le mot de passe", fontSize: 15.sp),
          leading: Icon(Icons.password),
          trailing: Icon(Icons.arrow_forward_ios),
          onPressed: (BuildContext context) {},
        ),
        SettingsTile.switchTile(
          title: text('Emprunte digit', fontSize: 17.5.sp, textColor: t12_text_color_primary),
          activeSwitchColor: KcolorPrimary,
          leading: Icon(Icons.fingerprint),
          onToggle: (bool value) {
            use_fingerprint = value;
            setState(() {});
          },
          initialValue: use_fingerprint,
        ),
      ]),
    ]);
  }
}
