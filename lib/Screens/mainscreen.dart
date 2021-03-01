import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with
    TickerProviderStateMixin {
  //Global Keys for all widgets in our page
  final greenKey = new GlobalKey();
  final blueKey = new GlobalKey();
  final orangeKey = new GlobalKey();
  final yellowKey = new GlobalKey();
  ScrollController scrollController;
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    double greenHeight;
    double blueHeight;
    double orangeHeight;
    double yellowHeight;

    scrollController.addListener(() {
      // we will need to check if user scrolling up or down
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (scrollController.offset > 0 &&
            scrollController.offset < greenHeight) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > greenHeight &&
            scrollController.offset < blueHeight + greenHeight) {
          _tabController.animateTo(1);
        } else if (scrollController.offset > blueHeight + greenHeight &&
            scrollController.offset <
                blueHeight + greenHeight + orangeHeight) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
            blueHeight + greenHeight + orangeHeight &&
            scrollController.offset <=
                blueHeight + greenHeight + orangeHeight + yellowHeight) {
          _tabController.animateTo(3);
        } else {}
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollController.offset < greenHeight) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > greenHeight &&
            scrollController.offset < blueHeight + greenHeight) {
          _tabController.animateTo(1);
        } else if (scrollController.offset > blueHeight + greenHeight &&
            scrollController.offset < blueHeight + greenHeight + orangeHeight) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
            blueHeight + greenHeight + orangeHeight &&
            scrollController.offset <
                blueHeight + greenHeight + orangeHeight + yellowHeight) {
          _tabController.animateTo(3);
        } else {}
      }
    });

    // if (greenKey.currentContext != null) {
    //   greenHeight = greenKey.currentContext.size.height;
    // }
    // if (blueKey.currentContext != null) {
    //   blueHeight = blueKey.currentContext.size.height;
    // }
    // if (orangeKey.currentContext != null) {
    //   orangeHeight = orangeKey.currentContext.size.height;
    // }
    // if (yellowKey.currentContext != null) {
    //   yellowHeight = yellowKey.currentContext.size.height;
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 200,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          makeTabBarHeader(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  key: greenKey,
                  height: 800,
                  color: Colors.green,
                ),
                Container(
                  key: blueKey,
                  height: 800,
                  color: Colors.blue,
                ),
                Container(
                  key: orangeKey,
                  height: 800,
                  color: Colors.orange,
                ),
                Container(
                  key: yellowKey,
                  height: 800,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //MakeTabBarHeader Function
  SliverPersistentHeader makeTabBarHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Container(
          color: Colors.white,
          child: TabBar(
            onTap: (val) {

              //Then We have added this on tap
                switch (val) {
                  case 0:
                    {
                      scrollController.position.ensureVisible(
                        greenKey.currentContext.findRenderObject(),
                        alignment: 0.0,
                        // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                    break;
                  case 1:
                    {
                      scrollController.position.ensureVisible(
                        blueKey.currentContext.findRenderObject(),
                        alignment: 0.0,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                    break;
                  case 2:
                    {
                      scrollController.position.ensureVisible(
                        orangeKey.currentContext.findRenderObject(),
                        alignment: 0.0,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                    break;
                  case 3:
                    {
                      scrollController.position.ensureVisible(
                        yellowKey.currentContext.findRenderObject(),
                        alignment: 0.0,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                    break;
                }

            },
            unselectedLabelColor: Colors.grey.shade700,
            indicatorColor: Colors.red,
            indicatorWeight: 2.0,
            labelColor: Colors.red,
            controller: _tabController,
            tabs: <Widget>[
              new Tab(
                child: Text(
                  "Green",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.green),
                ),
              ),
              new Tab(
                child: Text(
                  "Blue",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
              new Tab(
                child: Text(
                  "Orange",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
              new Tab(
                child: Text(
                  "Yellow",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
    );

  }

}

//SilverAppBar Delegate Class
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  
  final Widget child;
  @override
  double get minExtent => minHeight;


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => throw UnimplementedError();
}

