import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        accentColor: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        accentColor: Colors.green,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {Navigator.of(context).pop();},
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light ? Color(0xFFEFEFF4) : Colors.black,
        body: SafeArea(
          top: false,
          bottom: false,
          right: false,
          child: SettingsList(
            sections: [
              SettingsSection(
                title: 'Recording Start',
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Beep On Recording Start',
                    leading: Icon(Icons.volume_up),
                    switchValue: true,
                    onToggle: (bool value) {},
                  ),
                  SettingsTile.switchTile(
                    title: 'Flash On Recording Start',
                    leading: Icon(Icons.lightbulb_outline),
                    switchValue: true,
                    onToggle: (bool value) {},
                  ),
                ],
              ),
              SettingsSection(
                title: 'Recording End',
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Beep On Recording End',
                    leading: Icon(Icons.volume_up),
                    switchValue: true,
                    onToggle: (bool value) {},
                  ),
                  SettingsTile.switchTile(
                    title: 'Flash On Recording End',
                    leading: Icon(Icons.lightbulb_outline),
                    switchValue: true,
                    onToggle: (bool value) {},
                  ),
                ],
              ),
              SettingsSection(
                title: 'Ball Detection',
                tiles: [
                  SettingsTile(
                    title: 'Ball Color',
                    subtitle: 'White',
                    leading: Icon(Icons.palette),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
