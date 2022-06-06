import 'package:inventory_manager/models/inwardingPackageModel.dart';

class conflictedState {
  List<InwardingPackagesModel> conflictedPackages;
  String code, message;
  conflictedState(
      {required this.code,
      required this.message,
      required this.conflictedPackages});
}
