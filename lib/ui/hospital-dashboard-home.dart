import 'package:flutter/material.dart';
import 'package:invest_site/ui/account.card.dart';
import 'package:invest_site/utils/arguments.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
Color primaryColor = const Color(0xFFfbab66);

class HospitalDashboardHome extends StatelessWidget {
  const HospitalDashboardHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Dashboard'),
      backgroundColor: primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
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

  Widget _buildBottomBar() {
    return BottomAppBar(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.label_outline,
              size: 35,
              color: primaryColor,
            ),
            Icon(
              Icons.tune,
              size: 30,
              color: Colors.grey,

            ),
            Icon(
              Icons.perm_identity,
              color: Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final Arguments args = ModalRoute.of(context).settings.arguments;
    var balance = 2000.00;
    var chartData = new List<Invest>(args.data.length + 1);
    for (var i=0; i<args.data.length; i ++){
      chartData[i] = new Invest(args.data[i]['ticker']['ticker'].toString(), args.data[i]['share']);
      balance -= args.data[i]['share'];
    }
    chartData[args.data.length] = new Invest('balance', balance);
    final chartSeries = [new charts.Series<Invest, String>(
      id: 'shares',
      data: chartData,
      domainFn: (Invest invest, _) => invest.ticker,
      measureFn: (Invest invest, _) => invest.share,
//      colorFn: (_, __)=> charts.MaterialPalette.purple,
//      fillColorFn: (_, __)=> charts.MaterialPalette.purple.shadeDefault.lighter,
    )];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: DonutAutoLabelChart(chartSeries),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      children:<Widget>[
                        Text("New portfolio",
                          style: new TextStyle(
                          fontSize: 10.0,
                          color: Colors.black,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => _selectStock(context),
                          child: Icon(
                            FontAwesomeIcons.wrench,
                            color: Colors.black,
                            size: 20,
                          )
                        ),
                      ]
                    )
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: ListView(
                children:
                List.generate(args.data.length + 1, (i){
                  if (i == args.data.length){
                    return _buildCard(context,child:AccountCard(
                      name: '',
                      id: 'Balance',
                      time: '',
                      share: "\$" + balance.toString(),
                    )
                    );
                  } else{
                    return _buildCard(context,child:AccountCard(
                      name: args.data[i]['ticker']['name'].toString(),
                      id: args.data[i]['ticker']['ticker'].toString(),
                      time: args.data[i]['time'].toString().substring(0,10),
                      share: "\$" + args.data[i]['share'].toString(),
                    )
                    );
                  }
                })
              ),
            ),
          ),
        ),
      ],
    );
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

  void _selectStock(context){
    Navigator.pushNamed(context, '/select_stock', arguments: ModalRoute.of(context).settings.arguments);
  }
}

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }




}class Invest {
  final String ticker;
  final double share;

  Invest(this.ticker, this.share);
}