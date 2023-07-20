import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String firstName = "";
  double _appBarTitleFontSize = 14.0;
  ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> gridMap = [
    {"title": "Default Platters", "images": 'assets/soup.png'},
    {"title": "Craft Your Own", "images": 'assets/food.png'}
  ];

  final List<Map<String, dynamic>> gridMapFood = [
    {"title": "Rolls", "images": 'assets/roll.png'},
    {"title": "Drink", "images": 'assets/drink.png'},
    {"title": "Rice", "images": 'assets/rice.png'},
    {"title": "Curry", "images": 'assets/curry.png'},
    {"title": "Desert", "images": 'assets/desert.png'},
    {"title": "Starters", "images": 'assets/starter.png'}
  ];

  final List<Map<String, dynamic>> gridMapFood2 = [
    {"title": "Grill Chicken", "images": 'assets/gc.png'},
    {"title": "Mushroom Fry", "images": 'assets/mf.png'},
    {"title": "Veggies Fry", "images": 'assets/vf.png'},
  ];
  final List<Map<String, dynamic>> gridMapFood3 = [
    {"title": "Biryani", "images": 'assets/biry.png'},
    {"title": "Bread", "images": 'assets/bred.png'},
    {"title": "Plain Rice", "images": 'assets/rice2.png'},
  ];

  final List<Map<String, dynamic>> gridMapFood4 = [
    {"title": "Biryani", "images": 'assets/signature.png'},
    {"title": "Bread", "images": 'assets/value.png'},
    {"title": "Plain Rice", "images": 'assets/luxury.png'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateTitleFontSize);
    fetchFirstName();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateTitleFontSize);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchFirstName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final fullName = doc['full_name'];
      final splitName = fullName.split(' ');
      if (splitName.isNotEmpty) {
        setState(() {
          firstName = splitName[0];
        });
      }
    }
  }

  void _updateTitleFontSize() {
    if (_scrollController.offset > 100) {
      if (_appBarTitleFontSize != 10.0) {
        setState(() {
          _appBarTitleFontSize = 14.0;
        });
      }
    } else {
      if (_appBarTitleFontSize != 14.0) {
        setState(() {
          _appBarTitleFontSize = 14.0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, $firstName!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Lexend',
                          color: Color(0xFF6318AF),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Text(
                            'Current location',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF7B7B7B),
                            ),
                          ),
                          const SizedBox(width: 180),
                          Column(
                            children: [
                              Image.asset(
                                'assets/play.png', // Replace with your own image asset path
                                width: 24,
                                height: 24,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.black,
                          ),
                          Text(
                            'Bengaluru',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B7B7B),
                            ),
                          ),
                          SizedBox(width: 180),
                          Text('How it works?'),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 150.0,
                        width: 500.0,
                        child: AnotherCarousel(
                          images: const [
                            ExactAssetImage("assets/image1.png"),
                            ExactAssetImage("assets/image2.png")
                          ],
                          dotSize: 4.0,
                          dotSpacing: 15.0,
                          dotColor: const Color(0xFF6318AF),
                          indicatorBgPadding: 5.0,
                          dotBgColor: Colors.transparent,
                          borderRadius: true,
                          radius: const Radius.circular(18),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search food or events',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF6318AF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 60.0,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // Update font size based on the scroll offset

                  return FlexibleSpaceBar(
                    titlePadding:
                        const EdgeInsets.only(left: 20.0, bottom: 6.0),
                    title: Text(
                      'Start Crafting',
                      style: TextStyle(
                        fontSize: _appBarTitleFontSize,
                        fontFamily: 'Lexend',
                        color: Color(0xFF6318AF),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 241, 241, 241)
                                  .withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 189,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                        ),
                        itemCount: gridMap.length,
                        itemBuilder: (_, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                  ),
                                  child: Image.asset(
                                    gridMap[index]['images'],
                                    height: 145,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${gridMap.elementAt(index)['title']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        'assets/test1.png',
                        width: 575,
                        height: 149,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Top Categories',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lexend',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var item in gridMapFood)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      child: Image.asset(
                                        item['images'],
                                        height: 64,
                                        width: 64, // Adjust the width as needed
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            item['title'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Starters',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lexend',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var item in gridMapFood2)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      child: Image.asset(
                                        item['images'],
                                        height: 80,
                                        width:
                                            170, // Adjust the width as needed
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            item['title'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Main Course',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lexend',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var item in gridMapFood3)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      child: Image.asset(
                                        item['images'],
                                        height: 100,
                                        width:
                                            160, // Adjust the width as needed
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            item['title'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Services',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lexend',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var item in gridMapFood4)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      child: Image.asset(
                                        item['images'],
                                        height: 347,
                                        width:
                                            310, // Adjust the width as needed
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'How does it work ?',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lexend',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset('assets/hitw.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Delicious food with professional service !',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lexend',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
