import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:inventory_manager/models/currentUserModel.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'currentUserState.dart';

class currentUserCubit extends Cubit<currentUserState> {
  currentUserCubit()
      : super(currentUserState(code: "10", message: "", user: null));

  // void send(int phoneNo) => emit(OtpState(otpValue: phoneNo));
  getUser() async {
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    try {
      Response<Map> response = await dio.request(
        currentUserApi,
        options: Options(
          method: 'GET',
          headers: {'content-Type': 'application/json'},
        ),
      );
      String responseString = response.data.toString();
      print(responseString);
      Map? responseBody = response.data;

      CurrentUserModel user = CurrentUserModel.fromJson(responseBody!["user"]);
      emit(currentUserState(user: user, code: "00", message: "Success"));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(currentUserState(
            code: e.response!.data["code"],
            message: e.response!.data["message"],
            user: null));
        print("ayusj");
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(currentUserState(code: "10", message: "Catched", user: null));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(currentUserState(
            code: "10", message: 'check your connection', user: null));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(currentUserState(
            code: "10",
            message: 'unable to connect to the server',
            user: null));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');

        emit(currentUserState(
            code: "10", message: 'Something went wrong', user: null));
        return;
      }
    }
  }
}
