import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:beep/di/di.dart';
import 'package:beep/features/dashboard/domain/usecase/getroom_usecase.dart';
import 'package:beep/utils/router/arguments/chatscreen_argymenjt.dart';
import 'package:beep/utils/router/router.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    GetRoomDataUseCase getRoomDataUseCase = locator<GetRoomDataUseCase>();

    print(receivedAction.toMap());
    var notificationData = await getRoomDataUseCase.call(params: "");

    for (var element in notificationData.data!) {
      if (element.roomId == receivedAction.payload?['roomid']) {
        // Your code goes here
        AppRouter.navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(AppRoutes.chatScreen, (rout) => false,
                arguments: ChatscreenArgument(
                  name: element.recevierName ?? "",
                  phonenumber: element.receviernumber ?? "",
                  receiverId: element.recevierid ?? "",
                  roomid: element.roomId ?? "",
                ));
      }
    }
  }
}
