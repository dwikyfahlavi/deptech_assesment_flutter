import 'dart:ffi';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:deptech_assesment_flutter/constants/theme.dart';
import 'package:deptech_assesment_flutter/models/admin.dart';
import 'package:deptech_assesment_flutter/models/cuti_pegawai.dart';
import 'package:deptech_assesment_flutter/models/pegawai.dart';
import 'package:deptech_assesment_flutter/providers/admin_provider.dart';
import 'package:deptech_assesment_flutter/providers/cuti_provider.dart';
import 'package:deptech_assesment_flutter/providers/employee_provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCutiScreen extends StatefulWidget {
  CutiPegawai? cuti;
  AddCutiScreen({Key? key, this.cuti}) : super(key: key);

  @override
  State<AddCutiScreen> createState() => _AddCutiScreenState();
}

class _AddCutiScreenState extends State<AddCutiScreen> {
  int _idPegawai = 0;
  final _reason = TextEditingController();
  final _startCuti = TextEditingController();
  final _finishCuti = TextEditingController();

  @override
  void initState() {
    if (widget.cuti != null) {
      _idPegawai = widget.cuti!.id ?? 0;
      _reason.text = widget.cuti!.reason ?? "";
      _startCuti.text = widget.cuti!.startCuti ?? "";
      _finishCuti.text = widget.cuti!.finishCuti ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Cuti"),
      ),
      body: SingleChildScrollView(
        child: Consumer<CutiProvider>(builder: (context, value, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoolDropdown(
                  resultWidth: MediaQuery.of(context).size.width,
                  placeholder:
                      widget.cuti != null ? "${widget.cuti!.firstName} ${widget.cuti!.lastName}" : 'Choose Pegawai',
                  placeholderTS:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black.withOpacity(0.5)),
                  dropdownList: value.dropDownItemList,
                  onChange: (selectedItem) {
                    print(selectedItem['value']);
                    _idPegawai = selectedItem['value'];
                  },
                  gap: 10,
                  dropdownAlign: 'center',
                  resultBD: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  resultIcon: Container(
                    width: 10,
                    height: 10,
                    child: Icon(Icons.arrow_drop_down),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _reason,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Alasan Cuti",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      suffixIcon: IconButton(
                        onPressed: _reason.clear,
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Alasan Cuti';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Choose Date when you start cuti ?",
                  style: titleListTile.copyWith(color: Colors.black),
                ),
                DateTimePicker(
                  controller: _startCuti,
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }

                    return true;
                  },
                  onChanged: (val) {
                    print(val);
                    _startCuti.text = val;
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                SizedBox(height: 15),
                Text(
                  "Choose Date when you finish cuti ?",
                  style: titleListTile.copyWith(color: Colors.black),
                ),
                DateTimePicker(
                  controller: _finishCuti,
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }

                    return true;
                  },
                  onChanged: (val) {
                    print(val);
                    _finishCuti.text = val;
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.cuti != null) {
                        await context.read<CutiProvider>().updateCuti(
                              CutiPegawai(
                                  id: widget.cuti?.id,
                                  idPegawai: _idPegawai,
                                  reason: _reason.text.trim(),
                                  startCuti: _startCuti.text.trim(),
                                  finishCuti: _finishCuti.text.trim()),
                            );
                      } else {
                        await context.read<CutiProvider>().addCuti(CutiPegawai(
                            idPegawai: _idPegawai,
                            reason: _reason.text.trim(),
                            startCuti: _startCuti.text.trim(),
                            finishCuti: _finishCuti.text.trim()));
                      }
                      await context.read<CutiProvider>().getAllCuti();
                      Navigator.pop(context);
                    },
                    child: Text(widget.cuti != null ? "Update" : "Submit"),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
