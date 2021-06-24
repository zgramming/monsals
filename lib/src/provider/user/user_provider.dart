import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';

class UserProvider extends StateNotifier<UserModel> {
  UserProvider() : super(const UserModel());
  final dio = Dio();

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    var user = const UserModel();
    try {
      final data = FormData.fromMap({
        'username': username,
        'password': password,
      });
      final response = await dio.post(
        '${Constant.baseAPI}/login',
        data: data,
        options: Options(validateStatus: (status) => (status ?? 0) < 500),
      );

      log('JSON ${response.data}');
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      if (response.statusCode != 200) {
        final error = json['message'];
        throw Exception(error);
      }
      user = UserModel.fromJson(json['data'] as Map<String, dynamic>);
      await _setSession(user);

      state = user;
    } catch (e) {
      rethrow;
    }
    return user;
  }

  Future<bool> logout() async {
    var result = false;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      result = await prefs.remove(Constant.keySessionUser);
      if (!result) {
        throw 'Gagal melakukan logout di aplikasi';
      }
    } catch (e) {
      rethrow;
    }
    return result;
  }

  Future<bool> _setSession(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString(Constant.keySessionUser, json.encode(user));
    log('save session $result');
    return result;
  }

  Future<UserModel?> _getSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(Constant.keySessionUser);
    log('result get session $result');
    if (result == null) {
      return null;
    }

    final Map<String, dynamic> _json = json.decode(result) as Map<String, dynamic>;
    final user = UserModel.fromJson(_json);

    state = user;
    return user;
  }
}

final userProvider = StateNotifierProvider<UserProvider, UserModel>((ref) => UserProvider());

final readSession = FutureProvider.autoDispose<UserModel?>((ref) async {
  final _userProvider = ref.read(userProvider.notifier);
  final result = await _userProvider._getSession();
  return result;
});
