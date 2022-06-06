import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:inventory_manager/models/NotificationModel.dart';
import 'package:inventory_manager/provider/constants.dart';

import 'package:path_provider/path_provider.dart';

import 'notificationState.dart';

class notificationCubit extends Cubit<notificationState> {
  notificationCubit()
      : super(notificationState(code: "10", message: "", notifications: []));
  getNotifications() async {
    // final email = await userSecureStorage2.getEmail();
    // final password = await userSecureStorage2.getPaassword();
    //
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));

    try {
      Response<Map> response = await dio.request(
        getNotificationsApi,
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

      List<NotificationsModel> notification = [];
      responseBody!["notifications"].forEach((element) {
        NotificationsModel not = NotificationsModel.fromJson(element);
        notification.add(not);
      });

      emit(notificationState(
          code: "00", message: "", notifications: notification));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(notificationState(
            code: (e.response!.data["code"].toString()),
            message: e.response!.data["message"],
            notifications: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(notificationState(
            code: "10", message: 'catched', notifications: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(notificationState(
            code: "10", message: 'check your connection', notifications: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(notificationState(
            code: "10",
            message: 'unable to connect to the server',
            notifications: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(notificationState(
            code: "10", message: 'Something went wrong', notifications: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
