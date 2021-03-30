import 'package:cashier_app/models/menu_model.dart';
import 'package:cashier_app/models/pesanan_model.dart';
import 'package:cashier_app/pages/dashboard_page/dashboard_page.dart';
import 'package:cashier_app/pages/login_page/login_page.dart';
import 'package:cashier_app/pages/menu_page/menu_page.dart';
import 'package:cashier_app/services/myCashier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => MenuModel()),
        ChangeNotifierProvider(create: (context) => MyCashier()),
        ChangeNotifierProxyProvider<MenuModel, PesananModel>(
            create: (context) => PesananModel(),
            update: (context, menu, pesanan) {
              if (pesanan == null) throw ArgumentError.notNull('dashboard');
              pesanan.menu = menu;
              return pesanan;
            })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          "/": (context) => LoginPage(),
          "/dashboard": (context) => DashboardPage(),
          "/menu": (context) => MenuPage(),
        },
      ),
    );
  }
}
