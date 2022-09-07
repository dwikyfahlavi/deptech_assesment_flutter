import 'package:deptech_assesment_flutter/constants/state.dart';
import 'package:deptech_assesment_flutter/models/admin.dart';
import 'package:deptech_assesment_flutter/models/cuti_pegawai.dart';
import 'package:deptech_assesment_flutter/models/pegawai.dart';
import 'package:flutter/foundation.dart';
import 'package:deptech_assesment_flutter/services/databaseHelper.dart';

class CutiProvider extends ChangeNotifier {
  MyState _state = MyState.success;
  MyState get state => _state;

  List<CutiPegawai>? _cuti = [];
  List<CutiPegawai>? get cuti => _cuti;

  List<Pegawai>? _pegawai = [];
  List<Pegawai>? get pegawai => _pegawai;

  List _dropdownItemList = [];
  List get dropDownItemList => List.unmodifiable(_dropdownItemList);

  changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getAllCuti() async {
    changeState(MyState.loading);
    try {
      _cuti = await DatabaseHelper.instance.getCutibyPegawai();
      _pegawai = await DatabaseHelper.instance.getPegawai();
      List temp = _pegawai?.map((e) => {'label': "${e.firstName} ${e.lastName}", 'value': e.id}).toList() as List;
      _dropdownItemList = [...temp];
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error boss $e');
      notifyListeners();
    }
  }

  Future<void> addCuti(CutiPegawai cuti) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.addCuti(cuti);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> updateCuti(CutiPegawai cuti) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.updateCuti(cuti);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bosss $e');
      notifyListeners();
    }
  }

  Future<void> removeCuti(int cuti) async {
    changeState(MyState.loading);
    try {
      await DatabaseHelper.instance.removeAdmin(cuti);
      changeState(MyState.success);
    } catch (e) {
      changeState(MyState.error);
      print('error bosss $e');
      notifyListeners();
    }
  }
}
