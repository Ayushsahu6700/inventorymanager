import 'package:inventory_manager/models/inwardingPackageModel.dart';

class inwardingPackageState {
  List<InwardingPackagesModel> inwardingPackages;
  String code, message;
  inwardingPackageState(
      {required this.code,
      required this.message,
      required this.inwardingPackages});
}
