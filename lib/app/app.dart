import 'package:food_payed/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:food_payed/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:food_payed/ui/views/home/home_view.dart';
import 'package:food_payed/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:food_payed/services/firebase_auth_service.dart';
import 'package:food_payed/services/firebase_storage_service.dart';
import 'package:food_payed/ui/views/login/login_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FirebaseAuthService),
    LazySingleton(classType: FirebaseStorageService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
