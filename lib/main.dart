

import 'package:phoenix/src/beginning/utilities/audio_handlers/background.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/pages/settings/settings_pages/privacy.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/init.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/beginning/begin.dart';

void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await cacheImages();
  await dataInit();
  await fetchSongs();
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerTask(),
    config: const AudioServiceConfig(
      androidNotificationChannelName: "MusicApp",
      androidNotificationIcon: "drawable/phoenix_awaken",
      androidNotificationChannelDescription: "MusicApp Bildirimi",
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeOfApp,
      home: MultiProvider(
        
        providers: [
          ChangeNotifierProvider<Leprovider>(create: (_) => Leprovider()),
          ChangeNotifierProvider<MrMan>(
            create: (_) => MrMan(),
          ),
          ChangeNotifierProvider<Seek>(create: (_) => Seek()),
        ],
        child: permissionGiven ? const Begin() : const Privacy(),
      ),
    ),
  );
}
