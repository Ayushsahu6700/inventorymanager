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
import 'inwardingPackageState.dart';
import 'onHoldState.dart';

class onHoldCubit extends Cubit<onHoldState> {
  onHoldCubit()
      : super(onHoldState(code: "10", message: "", onHoldPackages: []));
  getList() async {
    final dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    try {
      Response<Map> response = await dio.request(
        onholdApi,
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

      List<InwardingPackagesModel> onHoldPackages = [];
      responseBody!["packages"].forEach((element) {
        InwardingPackagesModel onHoldPack =
            InwardingPackagesModel.fromJson(element);
        onHoldPackages.add(onHoldPack);
      });

      emit(
          onHoldState(code: "00", message: "", onHoldPackages: onHoldPackages));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(onHoldState(
            code: e.response!.data["code"],
            message: e.response!.data["message"],
            onHoldPackages: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(onHoldState(code: "10", message: 'catched', onHoldPackages: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(onHoldState(
            code: "10", message: 'check your connection', onHoldPackages: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(onHoldState(
            code: "10",
            message: 'unable to connect to the server',
            onHoldPackages: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(onHoldState(
            code: "10", message: 'Something went wrong', onHoldPackages: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
