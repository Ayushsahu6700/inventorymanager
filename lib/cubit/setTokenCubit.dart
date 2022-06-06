import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:inventory_manager/cubit/setTokenState.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class setTokenCubit extends Cubit<setTokenState> {
  setTokenCubit() : super(setTokenState(code: "10", message: ""));

  // void send(int phoneNo) => emit(OtpState(otpValue: phoneNo));
  setToken(String token) async {
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    try {
      Response<Map> response = await dio.request(
        setTokenApi,
        data: {"token": token},
        options: Options(
          method: 'PUT',
          headers: {'content-Type': 'application/json'},
        ),
      );
      Map? responseBody = response.data;
      if (responseBody!["code"] == "00") {
        emit(setTokenState(code: "00", message: "Success"));
      } else
        emit(setTokenState(code: "10", message: "Token Not Sent"));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(setTokenState(
            code: e.response!.data["code"],
            message: e.response!.data["message"]));
        print("ayusj");
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(setTokenState(code: "10", message: "Catched"));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(setTokenState(code: "10", message: 'check your connection'));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(setTokenState(
            code: "10", message: 'unable to connect to the server'));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');

        emit(setTokenState(code: "10", message: 'Something went wrong'));
        return;
      }
    }
  }
}
