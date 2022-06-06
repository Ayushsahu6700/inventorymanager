import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_manager/cubit/conflictedState.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:path_provider/path_provider.dart';
import 'approvedState.dart';
import 'inwardingPackageState.dart';
import 'onHoldState.dart';

class conflictedCubit extends Cubit<conflictedState> {
  conflictedCubit()
      : super(conflictedState(code: "10", message: "", conflictedPackages: []));
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
      // await dio.request(
      //   "https://api.sfcmanagement.in/api/inventoryManager/auth/login",
      //   data: {"email": email, "password": password},
      //   options: Options(
      //     method: 'POST',
      //     headers: {'content-Type': 'application/json'},
      //   ),
      // );
      Response<Map> response = await dio.request(
        conflictedApi,
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

      List<InwardingPackagesModel> conflictedPackages = [];
      responseBody!["packages"].forEach((element) {
        InwardingPackagesModel conflictedPack =
            InwardingPackagesModel.fromJson(element);
        conflictedPackages.add(conflictedPack);
      });

      emit(conflictedState(
          code: "00", message: "", conflictedPackages: conflictedPackages));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(conflictedState(
            code: e.response!.data["code"],
            message: e.response!.data["message"],
            conflictedPackages: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(conflictedState(
            code: "10", message: 'catched', conflictedPackages: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(conflictedState(
            code: "10",
            message: 'check your connection',
            conflictedPackages: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(conflictedState(
            code: "10",
            message: 'unable to connect to the server',
            conflictedPackages: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(conflictedState(
            code: "10",
            message: 'Something went wrong',
            conflictedPackages: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
