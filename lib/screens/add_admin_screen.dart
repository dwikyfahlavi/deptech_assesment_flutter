import 'package:deptech_assesment_flutter/models/admin.dart';

import 'package:deptech_assesment_flutter/providers/admin_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAdminScreen extends StatefulWidget {
  Admin? admin;
  AddAdminScreen({Key? key, this.admin}) : super(key: key);

  @override
  State<AddAdminScreen> createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    if (widget.admin != null) {
      _firstName.text = widget.admin!.firstName ?? "";
      _lastName.text = widget.admin!.lastName ?? "";
      _email.text = widget.admin!.email ?? "";
      _password.text = widget.admin!.password ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Admin"),
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
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _password,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      onPressed: _password.clear,
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
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (widget.admin != null) {
                      await context.read<AdminProvider>().updateAdmin(
                            Admin(
                              id: widget.admin?.id,
                              firstName: _firstName.text.trim(),
                              lastName: _lastName.text.trim(),
                              email: _email.text.trim(),
                              password: _password.text.trim(),
                            ),
                          );
                    } else {
                      await context.read<AdminProvider>().addAdmin(
                            Admin(
                              firstName: _firstName.text.trim(),
                              lastName: _lastName.text.trim(),
                              email: _email.text.trim(),
                              password: _password.text.trim(),
                            ),
                          );
                    }
                    await context.read<AdminProvider>().getAllAdmin();
                    Navigator.pop(context);
                  },
                  child: Text(widget.admin != null ? "Update" : "Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
