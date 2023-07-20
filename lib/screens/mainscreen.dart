import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/screens/bottomNavigationPages/homescreen.dart';
import 'bottomNavigationPages/orders.dart';
import 'bottomNavigationPages/profile.dart';
import 'bottomNavigationPages/wishlist.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;

  final List<Widget> screens = [
    HomeScreen(),
    WishListScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable going back to the previous screens
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF6318AF),
          child: Container(
            width: 40,
            height: 40,
            child: Image.asset('assets/logo/logo.png'),
          ),
          onPressed: () {
            Fluttertoast.showToast(
              msg: '🎊🥳 Congratulations, you got 20% discount FLAT!🍷🍺',
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = screens[0];
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color:
                            currentTab == 0 ? Color(0xFF6318AF) : Colors.grey,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color:
                              currentTab == 0 ? Color(0xFF6318AF) : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = screens[1];
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color:
                            currentTab == 1 ? Color(0xFF6318AF) : Colors.grey,
                      ),
                      Text(
                        'Wishlist',
                        style: TextStyle(
                          color:
                              currentTab == 1 ? Color(0xFF6318AF) : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 40), // Add some space between the buttons
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = screens[2];
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color:
                            currentTab == 2 ? Color(0xFF6318AF) : Colors.grey,
                      ),
                      Text(
                        'Orders',
                        style: TextStyle(
                          color:
                              currentTab == 2 ? Color(0xFF6318AF) : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = screens[3];
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color:
                            currentTab == 3 ? Color(0xFF6318AF) : Colors.grey,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color:
                              currentTab == 3 ? Color(0xFF6318AF) : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
