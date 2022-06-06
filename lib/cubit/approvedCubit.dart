import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:path_provider/path_provider.dart';
import 'approvedState.dart';
import 'inwardingPackageState.dart';
import 'onHoldState.dart';

class approvedCubit extends Cubit<approvedState> {
  approvedCubit()
      : super(approvedState(code: "10", message: "", approvedPackages: []));
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
        approvedApi,
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

      List<InwardingPackagesModel> approvedPackages = [];
      responseBody!["packages"].forEach((element) {
        InwardingPackagesModel approvedPack =
            InwardingPackagesModel.fromJson(element);
        approvedPackages.add(approvedPack);
      });

      emit(approvedState(
          code: "00", message: "", approvedPackages: approvedPackages));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(approvedState(
            code: e.response!.data["code"],
            message: e.response!.data["message"],
            approvedPackages: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(approvedState(
            code: "10", message: 'catched', approvedPackages: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(approvedState(
            code: "10",
            message: 'check your connection',
            approvedPackages: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(approvedState(
            code: "10",
            message: 'unable to connect to the server',
            approvedPackages: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(approvedState(
            code: "10", message: 'Something went wrong', approvedPackages: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
