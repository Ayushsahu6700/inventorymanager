import 'package:inventory_manager/models/inwardingPackageModel.dart';

class approvedState {
  List<InwardingPackagesModel> approvedPackages;
  String code, message;
  approvedState(
      {required this.code,
      required this.message,
      required this.approvedPackages});
}
