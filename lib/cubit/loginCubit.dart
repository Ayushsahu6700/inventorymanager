import 'dart:io';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:inventory_manager/models/loginModel.dart';
import 'package:meta/meta.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:convert';
import 'loginState.dart';
import 'package:path_provider/path_provider.dart';

class loginCubit extends Cubit<loginState> {
  loginCubit()
      : super(loginState(
            name: "", phoneNo: 0, email: "", code: "10", message: ""));

  // void send(int phoneNo) => emit(OtpState(otpValue: phoneNo));
  loginEmail(String email, String pass) async {
    final dio = Dio();
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    //
    // var cj = PersistCookieJar(
    //     ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    // dio.interceptors.add(CookieManager(cj));

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    try {
      var response = await dio.request(
        loginApi,
        data: {"email": email, "password": pass},
        options: Options(
          method: 'POST',
          headers: {'content-Type': 'application/json'},
        ),
      );
      var cookie = response.headers['set-cookie'];
      await userSecureStorage.setCookie(cookie);
      LoginModel signinModel = loginModelFromJson(response.data);
      emit(loginState(
          email: signinModel.user.email,
          name: signinModel.user.name,
          phoneNo: signinModel.user.phoneNo,
          code: signinModel.code,
          message: ""));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(loginState(
            name: "",
            phoneNo: 0,
            email: "",
            code: e.response!.data["code"],
            message: e.response!.data["message"]));
        print("ayusj");
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(loginState(
            name: "", phoneNo: 0, email: "", code: "10", message: "Catched"));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(loginState(
            name: "",
            phoneNo: 0,
            email: "",
            code: "10",
            message: 'check your connection'));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(loginState(
            name: "",
            phoneNo: 0,
            email: "",
            code: "10",
            message: 'unable to connect to the server'));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');

        emit(loginState(
            name: "",
            phoneNo: 0,
            email: "",
            code: "10",
            message: 'Something went wrong'));
        return;
      }
    }
  }
}
