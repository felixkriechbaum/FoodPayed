import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_payed/app/app.bottomsheets.dart';
import 'package:food_payed/app/app.dialogs.dart';
import 'package:food_payed/app/app.locator.dart';
import 'package:food_payed/app/app.router.dart';
import 'package:food_payed/firebase_options.dart';
import 'package:food_payed/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (isDesktop) {
    await windowManager.ensureInitialized();

    const double width = 500;
    const double height = width / 9 * 16;

    WindowOptions windowOptions = const WindowOptions(
      size: Size(width, height),
      maximumSize: Size(width, height),
      minimumSize: Size(width, height),
      fullScreen: false,
      alwaysOnTop: false,
      title: "Food Payed",
      windowButtonVisibility: true,
      center: true,
      skipTaskbar: false,
      backgroundColor: CupertinoColors.black,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
