import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:invest_site/ui/progress-button.dart'
    as ProgressButtonComponent;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import "package:invest_site/utils/arguments.dart";
import 'package:flutter/services.dart';
import 'package:invest_site/ui/account.card.dart';

Color primaryColor = const Color(0xFFfbab66);

class ProgressButton extends StatefulWidget {
  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var progress = 0.0;
  bool isDialog = false;
  final String ip = "47.101.168.207:8000";
//  final String ip = "192.168.0.131:8000";

  TextEditingController firstTicker = new TextEditingController();
  TextEditingController secondTicker = new TextEditingController();
  TextEditingController thirdTicker = new TextEditingController();
  TextEditingController fourthTicker = new TextEditingController();
  TextEditingController fifthTicker = new TextEditingController();
  TextEditingController sliderValue = new TextEditingController(text: '1000');

  Future<http.Response> sendPost(String url,
      {Map<String, dynamic> body}) async {
    final Arguments args = ModalRoute.of(context).settings.arguments;
    return http.post(
      url,
      body: body,
      headers: {"Authorization": " Token " + args.key},
    ).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        showInSnackBar("not in service");
      }
      return response;
    });
  }

  Future<void> _createMovement(done) async {
//    await Future.delayed(Duration(seconds: 1));
    var map = new Map<String, dynamic>();
    map['first'] = firstTicker.text;
    map['second'] = secondTicker.text;
    map['third'] = thirdTicker.text;
    map['fourth'] = fourthTicker.text;
    map['fifth'] = fifthTicker.text;
    map['val'] = double.parse(sliderValue.text).toString();
    final ans = await sendPost("http://" + ip + "/api/new-port/", body: map);
    bool successFlag = ans.statusCode == 202 ? true : false;
    final message = json.decode(ans.body);
    if (successFlag) {
      _bottomSheet(context, message);
    } else {
      showInSnackBar(message.toString());
    }
    return done(successFlag);
  }

//  Widget _floatB(){
//    if (isDialog){
//      return FloatingActionButton(
//          backgroundColor: Colors.deepOrange[800],
//
//          child: Icon(Icons.add_shopping_cart),
//          onPressed: null);
//    }else{
//      return Container();
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      floatingActionButton: _floatB(),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  textAlign: TextAlign.start,
                  controller: firstTicker,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "First Stock(input the ticker)",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.start,
                  controller: secondTicker,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Second Stock",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.start,
                  controller: thirdTicker,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Thrid Stock",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.start,
                  controller: fourthTicker,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Fourth Stock",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.start,
                  controller: fifthTicker,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Fifth Stock",
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Text('Total Amount'),
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: sliderValue,
                      ),
                    )
                  ],
                ),
                Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 2000.0,
                  onChanged: (val) {
                    setState(() => sliderValue.text = val.toString());
                  },
                  value: double.parse(sliderValue.text),
                ),
                ProgressButtonComponent.ProgressButton(
                  title: "Submmit",
                  operation: _createMovement,
                  canExecuteOperation: () => _formKey.currentState.validate(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: primaryColor,
      duration: Duration(seconds: 5),
    ));
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Dashboard'),
      backgroundColor: primaryColor,
      elevation: 0,
      actions: <Widget>[
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff00ff1d),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  void _bottomSheet(context, Map<String, dynamic> message) {
    setState(() {
      isDialog = true;
    });
    imageCache.clear();
    String id = message['user'].toString();
    message.remove('user');
    List<Widget> show = [];
    message.forEach((k, v) => show.add(_buildCard(context,
        child: AccountCard(
          name: k,
          id: '',
          time: 'Amount',
          share: "\$" + (v * double.parse(sliderValue.text)).toStringAsFixed(2),
        ))));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.88),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Plot Simulation",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  child:
                      Image.network("http://" + ip + "/media/" + id + ".png"),
                ),
                Container(
                  height: 280,
                  child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      children: show),
                ),
                Container(
                    child: IconButton(
                  icon: Icon(Icons.done_all),
                  onPressed: () => backToHome(message),
                  iconSize: 40,
                  color: Colors.red,
                )),
              ],
            ),
          );
        });
  }

  void backToHome(Map<String, dynamic> message) async {
    final Arguments args = ModalRoute.of(context).settings.arguments;
    await http.delete("http://" + ip + "/api/user-invest-remove/",
        headers: {"Authorization": " Token " + args.key});
    var count = 0;
    for (var key in message.keys) {
      await http.post(
        "http://" + ip + "/api/invest-create/",
        body: {
          "ticker": key,
          "share":
              (message[key] * double.parse(sliderValue.text)).toStringAsFixed(2)
        },
        headers: {"Authorization": " Token " + args.key},
      );
      count += 1;
      setState(() {
        progress = count / message.keys.length;
        print(progress);
      });
    }
//    message.forEach((k, v)  async =>  await http.post("http://192.168.0.131:8000/api/invest-create/", body: {"ticker":k, "share":(v * double.parse(sliderValue.text)).toStringAsFixed(2)}, headers: {"Authorization":" Token " + args.key},));
    var response = await http.get(
      'http://' + ip + '/api/user-invest/',
      headers: {"Authorization": " Token " + args.key},
    );
    print('data');
    print(json.decode(response.body));
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false,
        arguments: Arguments(args.key, json.decode(response.body)));
  }

  Widget _buildCard(context, {Widget child}) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}
