import 'package:cashier_app/pages/menu_page/menu_details.dart';
import 'package:cashier_app/services/myCashier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDialog extends ModalRoute<void> {
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.white.withOpacity(0.9);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    var myOrders = Provider.of<MyCashier>(context);
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Icon(Icons.close, color: Colors.black, size: 40),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Nama Pemesan"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: myOrders.myBaskets.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    onTap: () {
                      myOrders.setActiveMenu(myOrders.makanan[i]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuDetails()));
                    },
                    minVerticalPadding: 20,
                    leading: Image.network(
                      myOrders.makanan[i].pict.toString(),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title:
                        Text("nama : " + myOrders.makanan[i].name.toString()),
                    trailing: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                          Text(myOrders.makanan[i].qty.toString()),
                          Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
