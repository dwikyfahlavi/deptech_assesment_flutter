import 'package:deptech_assesment_flutter/constants/state.dart';
import 'package:deptech_assesment_flutter/models/admin.dart';
import 'package:deptech_assesment_flutter/models/pegawai.dart';
import 'package:flutter/foundation.dart';
import 'package:deptech_assesment_flutter/services/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProvider extends ChangeNotifier {
  MyState _state = MyState.success;
  MyState get state => _state;

  List<Admin>? _admin = [];
  List<Admin>? get admin => _admin;

  changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getAllAdmin() async {
    changeState(MyState.loading);
    try {
      _admin = await DatabaseHelper.instance.getAdmin();
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error boss $e');
      notifyListeners();
    }
  }

  Future<void> logoutAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    changeState(MyState.loading);
    try {
      await prefs.setBool('isLogin', false);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error boss $e');
      notifyListeners();
    }
  }

  Future<void> loginAdmin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    changeState(MyState.loading);
    try {
      bool cek = await DatabaseHelper.instance.loginAdmin(email, password);
      await prefs.setBool('isLogin', true);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error boss $e');
      notifyListeners();
    }
  }

  Future<void> addAdmin(Admin admin) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.addAdmin(admin);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> updateAdmin(Admin admin) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.updateAdmin(admin);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bosss $e');
      notifyListeners();
    }
  }

  Future<void> removeAdmin(int admin) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.removePegawai(admin);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bosss $e');
      notifyListeners();
    }
  }
}
