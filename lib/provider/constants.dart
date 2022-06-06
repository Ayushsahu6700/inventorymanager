import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  labelText: 'Amount',
  labelStyle: TextStyle(fontSize: 20.0),
  hintText: 'Enter your value',
  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xfffec260), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xfffec260), width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);
const kTextFieldDecoration2 = InputDecoration(
  hintText: 'Enter your value',
  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xfffec260), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xfffec260), width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const String pleaseEnterPassWordText = 'Please enter password';
const String passwordOfMinLength8Text = 'Password should be of min length 8';
const String pleaseEnterYourIdText = 'Please enter your id.';
const String enterValidEmailText = "Enter valid email";
const String loggedInText = "Logged In";
const String approvedApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/approved";
const String conflictedApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/disputed";
const String deliveryBoysApi =
    "https://api.sfcmanagement.in/api/inventoryManager/deliveryboys";
const String franchisesApi = "https://api.sfcmanagement.in/api/franchise";
const String branchesApi = "https://api.sfcmanagement.in/api/branch";
const String distributorsApi = "https://api.sfcmanagement.in/api/distributor";
const String hubsApi = "https://api.sfcmanagement.in/api/hub";
const String warehousesApi = "https://api.sfcmanagement.in/api/warehouse";
const String inwardApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/inward";
const String inwardingApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/inwarding";
const String loginApi =
    "https://api.sfcmanagement.in/api/inventoryManager/auth/login";
const String onholdApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/onhold";
const String outwardApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/outward";
const String outwardingApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/inwarded";
const String toApproveApi =
    "https://api.sfcmanagement.in/api/inventoryManager/package/sendforapproval";
const String countApi = "https://api.sfcmanagement.in/api/stats/count";
const String currentUserApi =
    "https://api.sfcmanagement.in/api/inventoryManager/auth/currentUser";
const String setTokenApi =
    "https://api.sfcmanagement.in/api/notification/settoken";
const String updateProfileApi =
    "https://api.sfcmanagement.in/api/inventoryManager/auth/edit";
const String getNotificationsApi =
    "https://api.sfcmanagement.in/api/notification";
const String markAllReadApi =
    "https://api.sfcmanagement.in/api/notification/read/all";
