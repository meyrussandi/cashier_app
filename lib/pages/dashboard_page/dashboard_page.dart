import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1,0.7],
          colors: [
            Colors.grey[350],
            Colors.grey[200],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(title: Text("MY DASHBOARD"),
              backgroundColor: Colors.transparent,)
            ];
          },
          body: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index){
                return Text("urutan : " + index.toString());
              })
            ),
          ),
        ),
      ),
    );
  }
}
