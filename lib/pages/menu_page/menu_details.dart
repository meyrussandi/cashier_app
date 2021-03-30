import 'package:cashier_app/services/myCashier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myMenu = Provider.of<MyCashier>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Menu Details"),
      ),
      body: Column(
        children: [
          Image.network(myMenu.activeMakanan.pict.toString()),
          Text(myMenu.activeMakanan.name.toString()),
          Text(myMenu.activeMakanan.price.toString()),
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    myMenu.removeToMyOrder(myMenu.activeMakanan);
                  },
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(myMenu.activeMakanan.qty.toString()),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    myMenu.addToMyOrder(myMenu.activeMakanan);
                  },
                  icon: Icon(Icons.add, color: Colors.blue),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
