import 'package:inventory_manager/models/currentUserModel.dart';

class currentUserState {
  String code;
  CurrentUserModel? user;
  String message;
  currentUserState(
      {required this.code, required this.message, required this.user});
}
