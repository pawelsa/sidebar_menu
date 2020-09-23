import 'package:flutter/material.dart';

final Color backgroundColor = Colors.white60;

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation _scaleAnimation;
  Animation _slideAnimation;
  Animation _menuScaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.6,
    ).animate(_controller);

    _slideAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(_controller);

    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[_buildMenu(), _buildDashboard()],
      ),
    );
  }

  Widget _buildMenu() {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            left: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dashboard",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Messages",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Utility Bills",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Funds Transfer",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Branches",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          elevation: 4,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(isCollapsed ? 0 : 40),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                            isCollapsed = !isCollapsed;
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "My cards",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 200,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.red,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.green,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.blue,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Transactions",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Macbook"),
                        subtitle: Text("Apple"),
                        trailing: Text("-2900"),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 16,
                      );
                    },
                    itemCount: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
