import 'package:inventory_manager/models/NotificationModel.dart';

class notificationState {
  List<NotificationsModel> notifications;
  String code, message;
  notificationState(
      {required this.code, required this.message, required this.notifications});
}
