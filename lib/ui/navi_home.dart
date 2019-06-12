import 'package:flutter/material.dart';
import 'package:invest_site/ui/network-bottom-navigate.dart';
import 'package:invest_site/ui/network-slide-item.dart';
import 'package:invest_site/style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color color1 = Color(0xff3f8abb);

class NetworkGasStationHome extends StatefulWidget {
  const NetworkGasStationHome({Key key}) : super(key: key);

  @override
  _NetworkGasStationHomeState createState() => _NetworkGasStationHomeState();
}

class _NetworkGasStationHomeState extends State<NetworkGasStationHome> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
        body: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Theme.Colors.loginGradientStart,
              Theme.Colors.loginGradientEnd
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text("Skip"),
              ),
            ),
            Flexible(
              flex: 9,
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  Container(
                    child: NetworkSlideItem(
                      title: "xxxx",
                      msg: "xxxxxxxxxxxxxxxx",
                      icon: FontAwesomeIcons.piggyBank,
                    ),
                  ),
                  Container(
                    child: NetworkSlideItem(
                      title: "xxxxxx",
                      msg: "Oxxxxxxxxxxxxxx",
                      icon: FontAwesomeIcons.chartLine,
                    ),
                  ),
                  Container(
                    child: NetworkSlideItem(
                      title: "xxxxxxxx",
                      msg: "xxxxxxxxxxxxxx",
                      icon: Icons.vpn_key,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: NetworkBottomNavigate(
                pageController: _pageController,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
