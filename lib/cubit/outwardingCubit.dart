import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:inventory_manager/models/outwardingPackageModel.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:path_provider/path_provider.dart';
import 'inwardingPackageState.dart';
import 'outwardingState.dart';

class outwardingPackageCubit extends Cubit<outwardingPackageState> {
  outwardingPackageCubit()
      : super(outwardingPackageState(
            code: "10", message: "", outwardingPackages: [], filterList: []));
  getList() async {
    // var cookie = userSecureStorage.getCookie();
    // print(cookie.toString() + "cokidnjndfvb------");
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
      // await dio.request(
      //   "https://api.sfcmanagement.in/api/inventoryManager/auth/login",
      //   data: {"email": email, "password": password},
      //   options: Options(
      //     method: 'POST',
      //     headers: {'content-Type': 'application/json'},
      //   ),
      // );
      Response<Map> response = await dio.request(
        outwardingApi,
        options: Options(
          method: 'GET',
          headers: {'content-Type': 'application/json'},
        ),
      );

      // print(response.data);
      print("Status code---------------------${response.statusCode}");
      String responseString = response.data.toString();
      print(responseString);
      Map? responseBody = response.data;
      Set<String> filterSet = Set();
      List<String> filterList = [];
      List<OutwardingPackageModel> outwardingPackages = [];
      responseBody!["packages"].forEach((element) {
        OutwardingPackageModel outwardingPack =
            OutwardingPackageModel.fromJson(element);
        outwardingPackages.add(outwardingPack);
        filterSet.add(element["deliveryAddress"]["city"]);
      });
      filterList.add("All cities");
      filterSet.forEach((element) {
        filterList.add(element);
      });

      emit(outwardingPackageState(
          code: "00",
          message: "",
          outwardingPackages: outwardingPackages,
          filterList: filterList));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(outwardingPackageState(
            code: (e.response!.data["code"].toString()),
            message: e.response!.data["message"],
            outwardingPackages: [],
            filterList: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(outwardingPackageState(
            code: "10",
            message: 'catched',
            outwardingPackages: [],
            filterList: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(outwardingPackageState(
            code: "10",
            message: 'check your connection',
            outwardingPackages: [],
            filterList: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(outwardingPackageState(
            code: "10",
            message: 'unable to connect to the server',
            outwardingPackages: [],
            filterList: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(outwardingPackageState(
            code: "10",
            message: 'Something went wrong',
            outwardingPackages: [],
            filterList: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
