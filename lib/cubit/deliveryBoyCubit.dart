import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:inventory_manager/provider/constants.dart';

import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:path_provider/path_provider.dart';

import 'deliveryBoyState.dart';

class deliveryBoyCubit extends Cubit<deliveryBoyState> {
  deliveryBoyCubit()
      : super(deliveryBoyState(
          list: [],
          map: {},
          type: "",
          message: "",
          code: "10",
        ));
  getList() async {
    // final dio = Dio();
    // var cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));
    // final email = await userSecureStorage2.getEmail();
    // final password = await userSecureStorage2.getPaassword();
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
      Response<Map> response = await dio.request(
        deliveryBoysApi,
        options: Options(
          method: 'GET',
          headers: {'content-Type': 'application/json'},
        ),
      );
      Map? responseBody = response.data;

      map["Select Delivery boy"] = "0";
      list.insert(0, "Select Delivery boy");
      responseBody!["deliveryBoys"].forEach((element) {
        String ele = element["name"];
        list.add(ele);
        map[element["name"]] = element["phoneNo"].toString();
      });

      // print(response.data);
      // print("Status code---------------------${response.statusCode}");
      // String responseString = response.data.toString();
      // print(responseString);

      emit(deliveryBoyState(
        list: list,
        map: map,
        type: "",
        message: "",
        code: "00",
      ));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(deliveryBoyState(
          list: [],
          map: {},
          type: "",
          message: e.response!.data["message"],
          code: e.response!.data["code"],
        ));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(deliveryBoyState(
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
        emit(deliveryBoyState(
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
        emit(deliveryBoyState(
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
        emit(deliveryBoyState(
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
      emit(deliveryBoyState(
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
