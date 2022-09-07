import 'package:deptech_assesment_flutter/constants/state.dart';
import 'package:deptech_assesment_flutter/constants/theme.dart';
import 'package:deptech_assesment_flutter/providers/admin_provider.dart';
import 'package:deptech_assesment_flutter/providers/cuti_provider.dart';
import 'package:deptech_assesment_flutter/screens/admin_screen.dart';
import 'package:deptech_assesment_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/employee_provider.dart';

class PegawaiScreen extends StatefulWidget {
  const PegawaiScreen({Key? key}) : super(key: key);

  @override
  State<PegawaiScreen> createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: Icon(Icons.login),
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
    );
  }
}

Widget buildEmployee() {
  return Consumer<EmployeeProvider>(
    builder: (context, value, _) {
      final isLoading = value.state == MyState.loading;
      final isError = value.state == MyState.error;

      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (isError) {
        return Text("No Data");
      }

      if (value.pegawai!.isEmpty) {
        return Text("No Data");
      }
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: value.pegawai?.length,
            itemBuilder: (context, index) {
              final pegawai = value.pegawai?[index];
              print(value.pegawai?.length);
              return ListTile(
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
      final isLoading = value.state == MyState.loading;
      final isError = value.state == MyState.error;

      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (isError) {
        return Text("No Data");
      }
      if (value.cuti!.isEmpty) {
        return Text("No Data");
      }
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: value.cuti?.length,
            itemBuilder: (context, index) {
              final cuti = value.cuti?[index];
              return ListTile(
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
      final isLoading = value.state == MyState.loading;
      final isError = value.state == MyState.error;

      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (isError) {
        return Text("No Data");
      }

      if (value.admin!.isEmpty) {
        return Text("No Data");
      }
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: value.admin?.length,
            itemBuilder: (context, index) {
              final admin = value.admin?[index];
              return ListTile(
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
              );
            },
          ),
        ),
      );
    },
  );
}
