import 'package:deptech_assesment_flutter/constants/state.dart';
import 'package:deptech_assesment_flutter/models/pegawai.dart';
import 'package:flutter/foundation.dart';
import 'package:deptech_assesment_flutter/services/databaseHelper.dart';

class EmployeeProvider extends ChangeNotifier {
  MyState _state = MyState.success;
  MyState get state => _state;

  List<Pegawai>? _pegawai = [];
  List<Pegawai>? get pegawai => _pegawai;

  changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getAllPegawai() async {
    changeState(MyState.loading);
    try {
      _pegawai = await DatabaseHelper.instance.getPegawai();
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error boss $e');
      notifyListeners();
    }
  }

  Future<void> addPegawai(Pegawai pegawai) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.addPegawai(pegawai);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> updatePegawai(Pegawai pegawai) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.updatePegawai(pegawai);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bosss $e');
      notifyListeners();
    }
  }

  Future<void> removePegawai(int pegawai) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.removePegawai(pegawai);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bosss $e');
      notifyListeners();
    }
  }
}
