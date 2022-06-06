import 'package:inventory_manager/models/inwardingPackageModel.dart';

class onHoldState {
  List<InwardingPackagesModel> onHoldPackages;
  String code, message;
  onHoldState(
      {required this.code,
      required this.message,
      required this.onHoldPackages});
}
