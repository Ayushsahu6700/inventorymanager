import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:inventory_manager/cubit/toApproveState.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'inwardState.dart';

class inwardCubit extends Cubit<inwardState> {
  inwardCubit()
      : super(inwardState(
          code: "10",
          message: "",
        ));
  inward(String packageId, double weight, double length, double width,
      double height) async {
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
        inwardApi,
        data: {
          "packageId": packageId,
          "weight": weight,
          "dimensions": {
            "width": width,
            "height": height,
            "length": length,
          }
        },
        options: Options(
          method: 'POST',
          headers: {'content-Type': 'application/json'},
        ),
      );

      // print(response.data);
      print("Status code---------------------${response.statusCode}");
      String responseString = response.data.toString();
      print(responseString);

      emit(inwardState(code: "00", message: ""));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(inwardState(
          code: e.response!.data["code"],
          message: e.response!.data["message"],
        ));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(inwardState(
          code: "10",
          message: 'catched',
        ));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(inwardState(
          code: "10",
          message: 'check your connection',
        ));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(inwardState(
          code: "10",
          message: 'unable to connect to the server',
        ));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(inwardState(
          code: "10",
          message: 'Something went wrong',
        ));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
