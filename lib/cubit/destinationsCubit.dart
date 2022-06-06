import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_manager/cubit/destinationState.dart';
import 'package:inventory_manager/models/branchModel.dart';
import 'package:inventory_manager/models/distributorModel.dart';
import 'package:inventory_manager/models/franchiseModel.dart';
import 'package:inventory_manager/models/hubModel.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:inventory_manager/models/retailerModel.dart';
import 'package:inventory_manager/models/warehouseModel.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inwardingPackageState.dart';

// class destinationCubit extends Cubit<destinationState> {
//   destinationCubit()
//       : super(destinationState(
//           franchiseList: [],
//           distributorList: [],
//           branchList: [],
//           hubList: [],
//           warehouseList: [],
//           message: "",
//           code: "10",
//           franchises: {},
//           distributors: {},
//           branches: {},
//           hubs: {},
//           warehouses: {},
//         ));
//   getList() async {
//     final dio = Dio();
//     var cookieJar = CookieJar();
//     dio.interceptors.add(CookieManager(cookieJar));
//     final email = await userSecureStorage2.getEmail();
//     final password = await userSecureStorage2.getPaassword();
//     final List<String>? franchiselist =
//         await userSecureStorage2.getFranchises();
//     final List<String>? distributorslist =
//         await userSecureStorage2.getDistributors();
//     final List<String>? brancheslist = await userSecureStorage2.getBranches();
//
//     final List<String>? hubslist = await userSecureStorage2.getHubs();
//     // final List<String>? warehouseslist =
//     //     await userSecureStorage2.getWarehouses();
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     List<String>? warehouselist = sharedPreferences.getStringList('warehouse');
//     final Map<String, String>? franchisemap =
//         await userSecureStorage2.getFranchisesmap();
//     final Map<String, String>? distributorsmap =
//         await userSecureStorage2.getDistributorsmap();
//     final Map<String, String>? branchesmap =
//         await userSecureStorage2.getBranchesmap();
//
//     final Map<String, String>? hubsmap = await userSecureStorage2.getHubsmap();
//     final Map<String, String>? warehousesmap =
//         await userSecureStorage2.getWarehousesmap();
//     try {
//       await dio.request(
//         "https://api.sfcmanagement.in/api/inventoryManager/auth/login",
//         data: {"email": email, "password": password},
//         options: Options(
//           method: 'POST',
//           headers: {'content-Type': 'application/json'},
//         ),
//       );
//       Response<Map> responsecount = await dio.request(
//         "https://api.sfcmanagement.in/api/stats/count",
//         options: Options(
//           method: 'GET',
//           headers: {'content-Type': 'application/json'},
//         ),
//       );
//       Map? responsecountBody1 = responsecount.data;
//
//       List<String> franchiseList = [];
//       Map<String, String> franchises = {};
//       if (franchiselist == null ||
//           (franchiselist.length - 1).toString() !=
//               responsecountBody1!["stats"]["franchises"].toString()) {
//         Response<Map> response1 = await dio.request(
//           "https://api.sfcmanagement.in/api/franchise",
//           options: Options(
//             method: 'GET',
//             headers: {'content-Type': 'application/json'},
//           ),
//         );
//         Map? responseBody1 = response1.data;
//
//         franchiseList.insert(0, "Select");
//         franchises["Select"] = "0";
//         responseBody1!["franchises"].forEach((element) {
//           String franchise = element["name"];
//           franchiseList.add(franchise);
//           franchises[element["name"]] = element["_id"];
//         });
//         await userSecureStorage2.setFranchises(franchiseList);
//         await userSecureStorage2.setFranchisesmap(franchises);
//       } else {
//         franchiseList = franchiselist;
//         franchises = franchisemap!;
//         print("autofr");
//       }
//       List<String> distributorList = [];
//       Map<String, String> distributors = {};
//       if (distributorslist == null ||
//           (distributorslist.length - 1) !=
//               responsecountBody1!["stats"]["distributors"]) {
//         Response<Map> response2 = await dio.request(
//           "https://api.sfcmanagement.in/api/distributor",
//           options: Options(
//             method: 'GET',
//             headers: {'content-Type': 'application/json'},
//           ),
//         );
//         Map? responseBody2 = response2.data;
//
//         distributors["Select"] = "0";
//         distributorList.insert(0, "Select");
//         responseBody2!["distributors"].forEach((element) {
//           String distributor = element["name"];
//           distributorList.add(distributor);
//           distributors[element["name"]] = element["_id"];
//         });
//
//         await userSecureStorage2.setDistributors(distributorList);
//         await userSecureStorage2.setDistributorsmap(distributors);
//       } else {
//         distributorList = distributorslist;
//         distributors = distributorsmap!;
//         print("autodi");
//       }
//       List<String> branchList = [];
//       Map<String, String> branches = {};
//       if (brancheslist == null ||
//           (brancheslist.length - 1) !=
//               responsecountBody1!["stats"]["branches"]) {
//         Response<Map> response3 = await dio.request(
//           "https://api.sfcmanagement.in/api/branch",
//           options: Options(
//             method: 'GET',
//             headers: {'content-Type': 'application/json'},
//           ),
//         );
//         Map? responseBody3 = response3.data;
//
//         branches["Select"] = "0";
//         branchList.insert(0, "Select");
//         responseBody3!["branchs"].forEach((element) {
//           String branch = element["name"];
//           branchList.add(branch);
//           branches[element["name"]] = element["_id"];
//         });
//
//         await userSecureStorage2.setBranches(branchList);
//         await userSecureStorage2.setBranchesmap(branches);
//       } else {
//         branchList = brancheslist;
//         branches = branchesmap!;
//         print("autobr");
//       }
//       List<String> hubList = [];
//       Map<String, String> hubs = {};
//       if (hubslist == null ||
//           (hubslist.length - 1) != responsecountBody1!["stats"]["hubs"]) {
//         Response<Map> response5 = await dio.request(
//           "https://api.sfcmanagement.in/api/hub",
//           options: Options(
//             method: 'GET',
//             headers: {'content-Type': 'application/json'},
//           ),
//         );
//         Map? responseBody5 = response5.data;
//
//         hubList.insert(0, "Select");
//         hubs["Select"] = "0";
//         responseBody5!["hubs"].forEach((element) {
//           String hub = element["name"];
//           hubList.add(hub);
//           hubs[element["name"]] = element["_id"];
//         });
//
//         await userSecureStorage2.setHubs(hubList);
//         await userSecureStorage2.setHubsmap(hubs);
//       } else {
//         hubList = hubslist;
//         hubs = hubsmap!;
//         print("autohub");
//       }
//       List<String> warehouseList = [];
//       Map<String, String> warehouses = {};
//       // print(warehouselist!.length.toString());
//       if (warehouselist == null ||
//           (warehouselist.length - 1) !=
//               responsecountBody1!["stats"]["warehouses"]) {
//         Response<Map> response6 = await dio.request(
//           "https://api.sfcmanagement.in/api/warehouse",
//           options: Options(
//             method: 'GET',
//             headers: {'content-Type': 'application/json'},
//           ),
//         );
//         Map? responseBody6 = response6.data;
//
//         warehouseList.insert(0, "Select");
//         warehouses["Select"] = "0";
//         responseBody6!["warehouses"].forEach((element) {
//           String warehouse = element["name"];
//           warehouseList.add(warehouse);
//           warehouses[element["name"]] = element["_id"];
//         });
//
//         final SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setStringList('warehouse', warehouseList);
//         await userSecureStorage2.setWarehousesmap(warehouses);
//       } else {
//         warehouseList = warehouselist;
//         warehouses = warehousesmap!;
//         print("autowr");
//       }
//
//       // print(response.data);
//       // print("Status code---------------------${response.statusCode}");
//       // String responseString = response.data.toString();
//       // print(responseString);
//
//       emit(destinationState(
//           franchiseList: franchiseList,
//           distributorList: distributorList,
//           branchList: branchList,
//           hubList: hubList,
//           warehouseList: warehouseList,
//           message: "",
//           code: "00",
//           franchises: franchises,
//           hubs: hubs,
//           distributors: distributors,
//           warehouses: warehouses,
//           branches: branches));
//     } on DioError catch (e) {
//       if (e.response != null) {
//         print(e.response!.data);
//         emit(destinationState(
//           franchiseList: [],
//           distributorList: [],
//           branchList: [],
//           hubList: [],
//           warehouseList: [],
//           message: e.response!.data["message"],
//           code: e.response!.data["code"],
//           franchises: {},
//           distributors: {},
//           branches: {},
//           hubs: {},
//           warehouses: {},
//         ));
//       } else if (e.type == DioErrorType.response) {
//         print('catched');
//         emit(destinationState(
//           franchiseList: [],
//           distributorList: [],
//           branchList: [],
//           hubList: [],
//           warehouseList: [],
//           message: 'catched',
//           code: "10",
//           franchises: {},
//           distributors: {},
//           branches: {},
//           hubs: {},
//           warehouses: {},
//         ));
//         return;
//       }
//       if (e.type == DioErrorType.connectTimeout) {
//         print('check your connection');
//         emit(destinationState(
//           franchiseList: [],
//           distributorList: [],
//           branchList: [],
//           hubList: [],
//           warehouseList: [],
//           message: 'check your connection',
//           code: "10",
//           franchises: {},
//           distributors: {},
//           branches: {},
//           hubs: {},
//           warehouses: {},
//         ));
//         return;
//       }
//
//       if (e.type == DioErrorType.receiveTimeout) {
//         print('unable to connect to the server');
//         emit(destinationState(
//           franchiseList: [],
//           distributorList: [],
//           branchList: [],
//           hubList: [],
//           warehouseList: [],
//           message: 'unable to connect to the server',
//           code: "10",
//           franchises: {},
//           distributors: {},
//           branches: {},
//           hubs: {},
//           warehouses: {},
//         ));
//         return;
//       }
//
//       if (e.type == DioErrorType.other) {
//         print('Something went wrong');
//         emit(destinationState(
//           franchiseList: [],
//           distributorList: [],
//           branchList: [],
//           hubList: [],
//           warehouseList: [],
//           message: 'Something went wrong',
//           code: "10",
//           franchises: {},
//           distributors: {},
//           branches: {},
//           hubs: {},
//           warehouses: {},
//         ));
//         return;
//       }
//       print(e);
//     } catch (e) {
//       print("error");
//       emit(destinationState(
//         franchiseList: [],
//         distributorList: [],
//         branchList: [],
//         hubList: [],
//         warehouseList: [],
//         message: "error",
//         code: "10",
//         franchises: {},
//         distributors: {},
//         branches: {},
//         hubs: {},
//         warehouses: {},
//       ));
//       print(e);
//     }
//   }
// }
class destinationCubit extends Cubit<destinationState> {
  destinationCubit()
      : super(destinationState(
          list: [],
          map: {},
          type: "",
          message: "",
          code: "10",
        ));
  getList(String type) async {
    // final dio = Dio();
    //     // var cookieJar = CookieJar();
    //     // dio.interceptors.add(CookieManager(cookieJar));
    //     // final email = await userSecureStorage2.getEmail();
    //     // final password = await userSecureStorage2.getPaassword();
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));

    try {
      List<String> list = [];
      Map<String, String> map = {};

      // await dio.request(
      //   "https://api.sfcmanagement.in/api/inventoryManager/auth/login",
      //   data: {"email": email, "password": password},
      //   options: Options(
      //     method: 'POST',
      //     headers: {'content-Type': 'application/json'},
      //   ),
      // );
      if (type == "franchise") {
        Response<Map> response = await dio.request(
          franchisesApi,
          options: Options(
            method: 'GET',
            headers: {'content-Type': 'application/json'},
          ),
        );
        Map? responseBody = response.data;

        map["Select"] = "0";
        list.insert(0, "Select");
        responseBody!["franchises"].forEach((element) {
          String ele = element["name"];
          list.add(ele);
          map[element["name"]] = element["_id"];
        });
      } else if (type == "distributor") {
        Response<Map> response = await dio.request(
          distributorsApi,
          options: Options(
            method: 'GET',
            headers: {'content-Type': 'application/json'},
          ),
        );
        Map? responseBody = response.data;

        map["Select"] = "0";
        list.insert(0, "Select");
        responseBody!["distributors"].forEach((element) {
          String ele = element["name"];
          list.add(ele);
          map[element["name"]] = element["_id"];
        });
      } else if (type == "branch") {
        Response<Map> response = await dio.request(
          branchesApi,
          options: Options(
            method: 'GET',
            headers: {'content-Type': 'application/json'},
          ),
        );
        Map? responseBody = response.data;

        map["Select"] = "0";
        list.insert(0, "Select");
        responseBody!["branchs"].forEach((element) {
          String ele = element["name"];
          list.add(ele);
          map[element["name"]] = element["_id"];
        });
      } else if (type == "hub") {
        Response<Map> response = await dio.request(
          hubsApi,
          options: Options(
            method: 'GET',
            headers: {'content-Type': 'application/json'},
          ),
        );
        Map? responseBody = response.data;

        map["Select"] = "0";
        list.insert(0, "Select");
        responseBody!["hubs"].forEach((element) {
          String ele = element["name"];
          list.add(ele);
          map[element["name"]] = element["_id"];
        });
      } else {
        Response<Map> response = await dio.request(
          warehousesApi,
          options: Options(
            method: 'GET',
            headers: {'content-Type': 'application/json'},
          ),
        );
        Map? responseBody = response.data;

        map["Select"] = "0";
        list.insert(0, "Select");
        responseBody!["warehouses"].forEach((element) {
          String ele = element["name"];
          list.add(ele);
          map[element["name"]] = element["_id"];
        });
      }

      // print(response.data);
      // print("Status code---------------------${response.statusCode}");
      // String responseString = response.data.toString();
      // print(responseString);

      emit(destinationState(
        list: list,
        map: map,
        type: type,
        message: "",
        code: "00",
      ));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(destinationState(
          list: [],
          map: {},
          type: "",
          message: e.response!.data["message"],
          code: e.response!.data["code"],
        ));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(destinationState(
          list: [],
          map: {},
          type: "",
          message: 'catched',
          code: "10",
        ));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(destinationState(
          list: [],
          map: {},
          type: "",
          message: 'check your connection',
          code: "10",
        ));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(destinationState(
          list: [],
          map: {},
          type: "",
          message: 'unable to connect to the server',
          code: "10",
        ));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(destinationState(
          list: [],
          map: {},
          type: "",
          message: 'Something went wrong',
          code: "10",
        ));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      emit(destinationState(
        list: [],
        map: {},
        type: "",
        message: "error",
        code: "10",
      ));
      print(e);
    }
  }
}
