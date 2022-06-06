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
import 'outwardState.dart';

class outwardCubit extends Cubit<outwardState> {
  outwardCubit()
      : super(outwardState(
          code: "10",
          message: "",
        ));
  outward(String packageId, String destinationId, String destinationName,
      String driverName, String vehicleNo, int driverContact) async {
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    final email = await userSecureStorage2.getEmail();

    try {
      Response<Map> response = await dio.request(
        outwardApi,
        data: {
          "packageId": packageId,
          "vehicleNo": vehicleNo,
          "destinationType": destinationName,
          "driverName": driverName,
          "driverContactNo": driverContact,
          "destinationId": destinationId
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

      emit(outwardState(code: "00", message: ""));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(outwardState(
          code: e.response!.data["code"],
          message: e.response!.data["message"],
        ));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(outwardState(
          code: "10",
          message: 'catched',
        ));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(outwardState(
          code: "10",
          message: 'check your connection',
        ));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(outwardState(
          code: "10",
          message: 'unable to connect to the server',
        ));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(outwardState(
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
