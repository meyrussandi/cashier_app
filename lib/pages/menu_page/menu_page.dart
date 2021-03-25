import 'package:cashier_app/models/menu_model.dart';
import 'package:cashier_app/models/pesanan_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var makanan = context.watch<MenuModel>();
    double widthSreen = MediaQuery.of(context).size.width;
    double heightSreen = MediaQuery.of(context).size.height;
    double defaultMargin = widthSreen * 0.1;
    return Scaffold(
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/dashboard");
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.greenAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.blue))),
                  ),
              child: Text(
                "Cek Pesanan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/dashboard");
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.blue))),
              ),
              child: Text(
                "Pesan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.green.shade900,
              title: Text("MENU"),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Makanan'),
                      Tab(text: 'Minuman'),
                    ],
                  ),
                )),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: makanan.items.length,
                      itemBuilder: (context, i){
                    return _MyListMenu(i);
                  }),
                  Text("tab 2"),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: heightSreen * 0.1,
              ),
            ),
            // SliverList(
            //     delegate: SliverChildBuilderDelegate((context, index) {
            //   return _MyListMenu(index);
            // }, childCount: makanan.items.length)),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}

class _AddButton extends StatelessWidget {
  final Makanan makanan;

  const _AddButton({required this.makanan, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInPesanan = context.select<PesananModel, bool>(
      (pesanan) => pesanan.items.contains(makanan),
    );
    return TextButton(
      onPressed:
      // isInPesanan ? null :
          ()
      {
              var pesanan = context.read<PesananModel>();
              pesanan.add(makanan);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child:
         // isInPesanan ?
          Icon(Icons.add, semanticLabel: 'ADDED')
             // : Text('ADD'),
    );
  }
}
class _MinButton extends StatelessWidget {
  final Makanan makanan;

  const _MinButton({required this.makanan, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInPesanan = context.select<PesananModel, bool>(
          (pesanan) => pesanan.items.contains(makanan),
    );
    return TextButton(
        onPressed:
         isInPesanan ?
            ()
        {
          var pesanan = context.read<PesananModel>();
          pesanan.remove(makanan);
        } : null,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            }
            return null; // Defer to the widget's default.
          }),
        ),
        child:
        // isInPesanan ?
        Icon(Icons.remove, semanticLabel: 'ADDED')
      // : Text('ADD'),
    );
  }
}

//TO DO: Coba buat pakai listViewBuilder
class _MyListMenu extends StatelessWidget {
  final int index;

  _MyListMenu(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var makanan = context.select<MenuModel, Makanan>(
      (menu) => menu.getByPosition(index),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(color: Colors.red),
            ),
            SizedBox(
              width: 24,
            ),
            Expanded(
                child: Text(
              makanan.nama,
              style: TextStyle(color: Colors.black),
            )),
            SizedBox(
              width: 24,
            ),
            _MinButton(makanan: makanan),
            Text(makanan.id.toString()),
            _AddButton(makanan: makanan)
          ],
        ),
      ),
    );
  }
}
