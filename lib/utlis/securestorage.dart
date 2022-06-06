import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class userSecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _cookie = 'cookie';
  static const _keyDriverName = 'driverName';
  static const _keyDriverPhoneno = 'driverPhoneno';
  static const _keyVehicleno = 'vehicleno';
  static const _keySelectDestinationType = 'destinationType';
  static const _keySelectedDestination = 'destination';
  static const _keyDeliveryBoyName = 'deliveryBoyName';
  static const _keyDeliveryVehicleno = 'deliveryVehicleno';

  static Future deleteData() async {
    await _storage.delete(key: _keyDriverName);
    await _storage.delete(key: _keyDriverPhoneno);
    await _storage.delete(key: _keyVehicleno);
    await _storage.delete(key: _keySelectDestinationType);
    await _storage.delete(key: _keySelectedDestination);
    await _storage.delete(key: _keyDeliveryBoyName);
    await _storage.delete(key: _keyDeliveryVehicleno);
  }

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyDriverName, value: username);
  static Future<String?> getUsername() async =>
      await _storage.read(key: _keyDriverName);
  static Future setPhoneno(String phoneno) async =>
      await _storage.write(key: _keyDriverPhoneno, value: phoneno);
  static Future<String?> getPhoneno() async =>
      await _storage.read(key: _keyDriverPhoneno);
  static Future setVehicleno(String vehicleno) async =>
      await _storage.write(key: _keyVehicleno, value: vehicleno);
  static Future<String?> getVehicleno() async =>
      await _storage.read(key: _keyVehicleno);
  static Future setDestinationType(String deatinationType) async =>
      await _storage.write(
          key: _keySelectDestinationType, value: deatinationType);
  static Future<String?> getDestinationType() async =>
      await _storage.read(key: _keySelectDestinationType);
  static Future setDestination(String destination) async =>
      await _storage.write(key: _keySelectedDestination, value: destination);
  static Future<String?> getDestination() async =>
      await _storage.read(key: _keySelectedDestination);

  static Future setCookie(var cookie) async =>
      await _storage.write(key: _cookie, value: 'cookie');

  static Future<dynamic?> getCookie() async =>
      await _storage.read(key: _cookie);
  static Future setDeliveryVehicleno(String vehicleno) async =>
      await _storage.write(key: _keyDeliveryVehicleno, value: vehicleno);
  static Future<String?> getDeliveryVehicleno() async =>
      await _storage.read(key: _keyDeliveryVehicleno);
  static Future setDeliveryBoyname(String username) async =>
      await _storage.write(key: _keyDeliveryBoyName, value: username);
  static Future<String?> getDeliveryBoyname() async =>
      await _storage.read(key: _keyDeliveryBoyName);
}

class userSecureStorage2 {
  static final _storage = FlutterSecureStorage();

  static const _keyEmail = 'useremail';

  static const _keyFranchises = 'franchises';
  static const _keyDistributors = 'distributors';
  static const _keyBranches = 'branches';
  static const _keyHubs = 'hubs';
  static const _keyWarehouses = 'warehouses';
  static const _keyDeliveryBoy = 'deliveryBoys';
  static const _keyFranchisesmap = 'franchisesmap';
  static const _keyDistributorsmap = 'distributorsmap';
  static const _keyBranchesmap = 'branchesmap';
  static const _keyHubsmap = 'hubsmap';
  static const _keyWarehousesmap = 'warehousesmap';
  static const _keyDeliveryBoymap = 'deliveryBoysmap';
  static Future deleteData() async {
    await _storage.deleteAll();
  }

  static Future setEmail(String email) async =>
      await _storage.write(key: _keyEmail, value: email);
  static Future<String?> getEmail() async =>
      await _storage.read(key: _keyEmail);
  static Future setBranches(List<String> branches) async {
    final value = json.encode(branches);
    await _storage.write(key: _keyBranches, value: value);
  }

  static Future<List<String>?> getBranches() async {
    final value = await _storage.read(key: _keyBranches);
    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setFranchises(List<String> franchises) async {
    final value = json.encode(franchises);
    await _storage.write(key: _keyFranchises, value: value);
  }

  static Future<List<String>?> getFranchises() async {
    final value = await _storage.read(key: _keyFranchises);
    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setDistributors(List<String> distributors) async {
    final value = json.encode(distributors);
    await _storage.write(key: _keyDistributors, value: value);
  }

  static Future<List<String>?> getDistributors() async {
    final value = await _storage.read(key: _keyDistributors);
    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setHubs(List<String> hubs) async {
    final value = json.encode(hubs);
    await _storage.write(key: _keyHubs, value: value);
  }

  static Future<List<String>?> getHubs() async {
    final value = await _storage.read(key: _keyHubs);
    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setWarehouses(List<String> warehouses) async {
    final value = json.encode(warehouses);
    await _storage.write(key: _keyWarehouses, value: value);
  }

  static Future<List<String>?> getWarehouses() async {
    final value = await _storage.read(key: _keyWarehouses);
    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setBranchesmap(Map<String, String> branches) async {
    final value = json.encode(branches);
    await _storage.write(key: _keyBranchesmap, value: value);
  }

  static Future<Map<String, String>?> getBranchesmap() async {
    final value = await _storage.read(key: _keyBranchesmap);
    return value == null ? null : Map<String, String>.from(json.decode(value));
  }

  static Future setFranchisesmap(Map<String, String> franchises) async {
    final value = json.encode(franchises);
    await _storage.write(key: _keyFranchisesmap, value: value);
  }

  static Future<Map<String, String>?> getFranchisesmap() async {
    final value = await _storage.read(key: _keyFranchisesmap);
    return value == null ? null : Map<String, String>.from(json.decode(value));
  }

  static Future setDistributorsmap(Map<String, String> distributors) async {
    final value = json.encode(distributors);
    await _storage.write(key: _keyDistributorsmap, value: value);
  }

  static Future<Map<String, String>?> getDistributorsmap() async {
    final value = await _storage.read(key: _keyDistributorsmap);
    return value == null ? null : Map<String, String>.from(json.decode(value));
  }

  static Future setHubsmap(Map<String, String> hubs) async {
    final value = json.encode(hubs);
    await _storage.write(key: _keyHubsmap, value: value);
  }

  static Future<Map<String, String>?> getHubsmap() async {
    final value = await _storage.read(key: _keyHubsmap);
    return value == null ? null : Map<String, String>.from(json.decode(value));
  }

  static Future setWarehousesmap(Map<String, String> warehouses) async {
    final value = json.encode(warehouses);
    await _storage.write(key: _keyWarehousesmap, value: value);
  }

  static Future<Map<String, String>?> getWarehousesmap() async {
    final value = await _storage.read(key: _keyWarehousesmap);
    return value == null ? null : Map<String, String>.from(json.decode(value));
  }

  static Future setDeliveryBoy(List<String> deliveryBoys) async {
    final value = json.encode(deliveryBoys);
    await _storage.write(key: _keyDeliveryBoy, value: value);
  }

  static Future<List<String>?> getDeliveryBoy() async {
    final value = await _storage.read(key: _keyDeliveryBoy);
    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setDeliveryBoymap(Map<String, String> deliveryBoys) async {
    final value = json.encode(deliveryBoys);
    await _storage.write(key: _keyDeliveryBoymap, value: value);
  }

  static Future<Map<String, String>?> getDeliveryBoymap() async {
    final value = await _storage.read(key: _keyDeliveryBoymap);
    return value == null ? null : Map<String, String>.from(json.decode(value));
  }
}
