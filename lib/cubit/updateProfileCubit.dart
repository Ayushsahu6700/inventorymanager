import 'dart:io';

import 'package:http_parser/http_parser.dart';

import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'currentUserState.dart';
import 'updateProfileState.dart';

class updateProfileCubit extends Cubit<updateProfileState> {
  updateProfileCubit() : super(updateProfileState(code: "10", message: ""));

  // void send(int phoneNo) => emit(OtpState(otpValue: phoneNo));
  updateProfile(String name, File? file1, File? file2, String email,
      String phoneNo, String oldPass, String newPass) async {
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    Map<String, dynamic> map = {};
    if (name != "") map["name"] = name;
    if (email != "") map["email"] = email;
    if (phoneNo != "") map["phoneNo"] = phoneNo;
    if (oldPass != "") {
      map["oldPassword"] = oldPass;
      map["newPassword"] = newPass;
    }
    if (file1 != null) {
      String filename = file1.path.split('/').last;

      map["profilePicture"] = await MultipartFile.fromFile(file1.path,
          filename: filename, contentType: MediaType("image", "jpeg"));
    }
    if (file2 != null) {
      String filename = file2.path.split('/').last;

      map["document"] = await MultipartFile.fromFile(file2.path,
          filename: filename, contentType: MediaType("image", "jpeg"));
    }
    FormData formData = FormData.fromMap(map);
    try {
      Response<Map> response = await dio.request(
        updateProfileApi,
        data: formData,
        options: Options(
          method: 'PUT',
          headers: {'content-Type': 'application/json'},
        ),
      );
      String responseString = response.data.toString();
      print(responseString);
      Map? responseBody = response.data;

      emit(updateProfileState(
        code: "00",
        message: "Success",
      ));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(updateProfileState(
          code: e.response!.data["code"],
          message: e.response!.data["message"],
        ));
        print("ayusj");
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(updateProfileState(code: "10", message: "Catched"));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(updateProfileState(
          code: "10",
          message: 'check your connection',
        ));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(updateProfileState(
          code: "10",
          message: 'unable to connect to the server',
        ));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');

        emit(updateProfileState(
          code: "10",
          message: 'Something went wrong',
        ));
        return;
      }
    }
  }
}
