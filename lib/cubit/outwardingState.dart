import 'package:inventory_manager/models/outwardingPackageModel.dart';

class outwardingPackageState {
  List<OutwardingPackageModel> outwardingPackages;
  List<String> filterList;
  String code, message;
  outwardingPackageState(
      {required this.code,
      required this.message,
      required this.outwardingPackages,
      required this.filterList});
}
