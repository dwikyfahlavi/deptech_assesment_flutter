import 'package:deptech_assesment_flutter/providers/admin_provider.dart';
import 'package:deptech_assesment_flutter/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your email",
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
                      return 'Please Enter Your email';
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
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                      return 'Please Enter Your password';
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
                    await context.read<AdminProvider>().loginAdmin(_email.text.trim(), _password.text.trim());
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => const AdminScreen()), (route) => false);
                  },
                  child: Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
