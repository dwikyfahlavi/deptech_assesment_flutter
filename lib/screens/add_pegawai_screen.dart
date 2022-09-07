import 'package:deptech_assesment_flutter/models/cuti_pegawai.dart';
import 'package:deptech_assesment_flutter/models/pegawai.dart';
import 'package:deptech_assesment_flutter/providers/cuti_provider.dart';
import 'package:deptech_assesment_flutter/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPegawaiScreen extends StatefulWidget {
  Pegawai? pegawai;
  AddPegawaiScreen({Key? key, this.pegawai}) : super(key: key);

  @override
  State<AddPegawaiScreen> createState() => _AddPegawaiScreenState();
}

class _AddPegawaiScreenState extends State<AddPegawaiScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _gender = TextEditingController();

  @override
  void initState() {
    if (widget.pegawai != null) {
      _firstName.text = widget.pegawai!.firstName ?? "";
      _lastName.text = widget.pegawai!.lastName ?? "";
      _email.text = widget.pegawai!.email ?? "";
      _phone.text = widget.pegawai!.phone ?? "";
      _address.text = widget.pegawai!.address ?? "";
      _gender.text = widget.pegawai!.gender ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pegawai != null ? "Update Pegawai" : "Add Pegawai"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _firstName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your first name",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      onPressed: _firstName.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your first name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _lastName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your last name",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      onPressed: _lastName.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your last name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "e.g lets.moot@example.com",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      onPressed: _email.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Email';
                    } else if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                        .hasMatch(value ?? "")) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your phone number",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      onPressed: _phone.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your phone number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _address,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your address",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      onPressed: _address.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _gender,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your gender",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      onPressed: _gender.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter gender';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (widget.pegawai != null) {
                      await context.read<EmployeeProvider>().updatePegawai(
                            Pegawai(
                              id: widget.pegawai?.id,
                              firstName: _firstName.text.trim(),
                              lastName: _lastName.text.trim(),
                              email: _email.text.trim(),
                              phone: _phone.text.trim(),
                              address: _address.text.trim(),
                              gender: _gender.text.trim(),
                            ),
                          );
                    } else {
                      await context.read<EmployeeProvider>().addPegawai(
                            Pegawai(
                              firstName: _firstName.text.trim(),
                              lastName: _lastName.text.trim(),
                              email: _email.text.trim(),
                              phone: _phone.text.trim(),
                              address: _address.text.trim(),
                              gender: _gender.text.trim(),
                            ),
                          );
                    }
                    await context.read<EmployeeProvider>().getAllPegawai();
                    await context.read<CutiProvider>().getAllCuti();

                    Navigator.pop(context);
                  },
                  child: Text(widget.pegawai != null ? "Update" : "Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
