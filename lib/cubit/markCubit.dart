import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'markState.dart';
import 'markAllReadState.dart';

class markCubit extends Cubit<markState> {
  markCubit() : super(markState(code: "10", message: ""));

  // void send(int phoneNo) => emit(OtpState(otpValue: phoneNo));
  mark(String id) async {
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    try {
      Response<Map> response = await dio.request(
        "https://api.sfcmanagement.in/api/notification/read/${id.toString()}",
        options: Options(
          method: 'PUT',
          headers: {'content-Type': 'application/json'},
        ),
      );
      Map? responseBody = response.data;
      if (responseBody!["code"] == "00") {
        emit(markState(code: "00", message: "Success"));
      } else
        emit(markState(code: "10", message: "Token Not Sent"));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(markState(
            code: e.response!.data["code"],
            message: e.response!.data["message"]));
        print("ayusj");
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(markState(code: "10", message: "Catched"));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(markState(code: "10", message: 'check your connection'));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(markState(code: "10", message: 'unable to connect to the server'));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');

        emit(markState(code: "10", message: 'Something went wrong'));
        return;
      }
    }
  }
}
