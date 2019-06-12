import 'package:flutter/material.dart';
import 'package:invest_site/ui/login_page.dart';
import 'package:invest_site/ui/navi_home.dart';
import 'package:invest_site/ui/hospital-dashboard-home.dart';
import 'package:invest_site/ui/submit_stock.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginPage(),
  '/' :          (BuildContext context) => new NetworkGasStationHome(),
  '/select_stock':   (BuildContext context) => new ProgressButton(),
  '/dashboard':   (BuildContext context) => new HospitalDashboardHome(),

};