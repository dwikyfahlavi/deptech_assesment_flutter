import 'package:deptech_assesment_flutter/constants/theme.dart';
import 'package:deptech_assesment_flutter/models/admin.dart';
import 'package:deptech_assesment_flutter/models/cuti_pegawai.dart';
import 'package:deptech_assesment_flutter/providers/admin_provider.dart';
import 'package:deptech_assesment_flutter/providers/cuti_provider.dart';
import 'package:deptech_assesment_flutter/screens/add_admin_screen.dart';
import 'package:deptech_assesment_flutter/screens/add_cuti_screen.dart';
import 'package:deptech_assesment_flutter/screens/add_pegawai_screen.dart';
import 'package:deptech_assesment_flutter/screens/pegawai_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/employee_provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[buildEmployee(), buildEmployeeCuti(), buildAdmin()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EmployeeProvider>(context, listen: false).getAllPegawai();
      Provider.of<CutiProvider>(context, listen: false).getAllCuti();
      Provider.of<AdminProvider>(context, listen: false).getAllAdmin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AdminProvider>().logoutAdmin();
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => const PegawaiScreen()), (route) => false);
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          )
        ],
        title: Text("Deptech Screen"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village),
            label: 'Cuti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Admin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            if (_selectedIndex == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddPegawaiScreen()));
            } else if (_selectedIndex == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddCutiScreen()));
            } else if (_selectedIndex == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAdminScreen()));
            }
          }),
    );
  }
}

Widget buildEmployee() {
  return Consumer<EmployeeProvider>(
    builder: (context, value, _) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: value.pegawai?.length,
            itemBuilder: (context, index) {
              final pegawai = value.pegawai?[index];
              return InkWell(
                onLongPress: () async {
                  await value.removePegawai(pegawai?.id ?? 0);
                  await value.getAllPegawai();
                  await context.read<CutiProvider>().getAllCuti();
                },
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddPegawaiScreen(pegawai: pegawai)));
                },
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${pegawai?.firstName} ${pegawai?.lastName}",
                        style: titleList,
                      ),
                      Text(
                        "${pegawai?.email}",
                        style: subtitleList,
                      ),
                      Text(
                        "+62${pegawai?.phone}",
                        style: subtitleList,
                      ),
                      Text(
                        "${pegawai?.address}",
                        style: subtitleList,
                      ),
                      Text(
                        "${pegawai?.gender}",
                        style: subtitleList,
                      ),
                      SizedBox(height: 15)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

Widget buildEmployeeCuti() {
  return Consumer<CutiProvider>(
    builder: (context, value, _) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: value.cuti?.length,
            itemBuilder: (context, index) {
              final cuti = value.cuti?[index];
              return InkWell(
                onLongPress: () async {
                  await value.removeCuti(cuti?.id ?? 0);
                  await value.getAllCuti();
                },
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCutiScreen(cuti: cuti)));
                },
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cuti?.firstName} ${cuti?.lastName}",
                        style: titleList,
                      ),
                      Text(
                        "${cuti?.reason}",
                        style: subtitleList,
                      ),
                      Text(
                        "${cuti?.startCuti}",
                        style: subtitleList,
                      ),
                      Text(
                        "${cuti?.finishCuti}",
                        style: subtitleList,
                      ),
                      SizedBox(height: 15)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

Widget buildAdmin() {
  return Consumer<AdminProvider>(
    builder: (context, value, _) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: value.admin?.length,
            itemBuilder: (context, index) {
              final admin = value.admin?[index];
              return InkWell(
                onLongPress: () async {
                  await value.removeAdmin(admin?.id ?? 0);
                  await value.getAllAdmin();
                },
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddAdminScreen(admin: admin)));
                },
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${admin?.firstName} ${admin?.lastName}",
                        style: titleList,
                      ),
                      Text(
                        "${admin?.email}",
                        style: subtitleList,
                      ),
                      SizedBox(height: 15)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
