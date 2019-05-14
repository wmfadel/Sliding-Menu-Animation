import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double screenWidth;
  double screenHeight;
  bool isCollapsed = true;
  final Duration duration = Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildMenu(context),
          buildBody(context),
        ],
      ),
    );
  }

  Widget buildMenu(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://i.ytimg.com/vi/7Xu_s1YJhyg/maxresdefault.jpg'),
                ),
                SizedBox(height: 20),
                Text("Dashboard",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                SizedBox(height: 10),
                Text("Messages",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                SizedBox(height: 10),
                Text("Utility Bills",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                SizedBox(height: 10),
                Text("Funds Transfer",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                SizedBox(height: 10),
                Text("Branches",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.4 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          elevation: 12,
          animationDuration: duration,
          borderRadius: BorderRadius.circular(8),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            isCollapsed
                                ? _controller.forward()
                                : _controller.reverse();
                            isCollapsed = !isCollapsed;
                          });
                        }),
                    Text('Home Page', style: TextStyle(fontSize: 18)),
                    Icon(Icons.settings),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: PageView(
                  controller: PageController(viewportFraction: 0.8),
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      width: 100,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent,
                      ),
                      width: 100,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key('key$index'),
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.blueAccent,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.archive,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text("List item title"),
                        subtitle: Text("the subtitle"),
                        leading: Icon(Icons.favorite_border, color: Colors.red),
                        trailing: Icon(Icons.navigate_next, color: Colors.blue),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 16);
                  },
                  itemCount: 10),
            ],
          ),
        ),
      ),
    );
  }
}
