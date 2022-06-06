import 'package:inventory_manager/models/branchModel.dart';
import 'package:inventory_manager/models/distributorModel.dart';
import 'package:inventory_manager/models/franchiseModel.dart';
import 'package:inventory_manager/models/hubModel.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:inventory_manager/models/retailerModel.dart';
import 'package:inventory_manager/models/warehouseModel.dart';

// class destinationState {
//   List<String> franchiseList;
//   Map<String, String> franchises;
//   List<String> distributorList;
//   Map<String, String> distributors;
//   List<String> branchList;
//   Map<String, String> branches;
//
//   List<String> hubList;
//   Map<String, String> hubs;
//   List<String> warehouseList;
//   Map<String, String> warehouses;
//   String code, message;
//   destinationState(
//       {required this.franchiseList,
//       required this.distributorList,
//       required this.branchList,
//       required this.hubList,
//       required this.warehouseList,
//       required this.message,
//       required this.code,
//       required this.franchises,
//       required this.distributors,
//       required this.branches,
//       required this.hubs,
//       required this.warehouses});
// }
class destinationState {
  List<String> list;
  Map<String, String> map;
  String type;

  String code, message;
  destinationState({
    required this.list,
    required this.map,
    required this.type,
    required this.message,
    required this.code,
  });
}
