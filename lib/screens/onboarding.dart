import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../content_desc.dart';
import 'loginsignuppage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 630.0, end: 660.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/skip.png',
                    width: 70.0,
                    height: 70.0,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentPage = index;
                      if (currentPage == 1) {
                        _animationController.forward(from: 0.0);
                      } else if (currentPage == 0) {
                        _animationController.forward(from: 0.0);
                      } else {
                        _animationController.reverse(from: 1.0);
                      }
                    });
                  },
                  itemCount: contents.length,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Align items to the top
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            child: RiveAnimation.asset(
                              contents[i].image,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            contents[i].title,
                            style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            contents[i].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              color: Color.fromRGBO(123, 123, 123, 1),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: _animation.value, // Use the animated value for top position
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildIndicator(index),
              ),
            ),
          ),
          Positioned(
            top: 692, // Adjust the initial top position as needed
            child: currentPage != 2
                ? ImageButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    image: Image.asset('assets/nextButton.png'),
                  )
                : ImageButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginPage(), // Replace LoginPage with the actual name of your login page widget
                        ),
                      );
                    },
                    image: Image.asset('assets/getStarted.png'),
                  ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  AnimatedContainer buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: currentPage == index ? 12 : 8,
      width: currentPage == index ? 24 : 12,
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color.fromRGBO(96, 23, 170, 1)
            : const Color.fromARGB(255, 224, 224, 224),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Image image;

  const ImageButton({
    Key? key,
    required this.onPressed,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: image,
      ),
    );
  }
}
