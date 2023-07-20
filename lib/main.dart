import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/mainscreen.dart';
import 'package:test/screens/onboarding.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CraftMyPlate',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var _breathe = 0.0;
  late AnimationController _animationController;
  late AnimationController _logoAnimationController;
  late Animation<double> _vectorAnimation;
  late Animation<double> _vectorAnimationLogo;
  late Animation<double> _textFadeOutAnimation;
  late Animation<double> _textFadeInAnimation;
  late Animation<double> _logoVerticalTranslationAnimation;
  late Animation<double> _verticalAmplitudeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    );
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoAnimationController.forward();
      }
    });
    _logoAnimationController.addListener(() {
      setState(() {
        _breathe = _logoAnimationController.value;
      });
    });
    _logoAnimationController.forward();

    _vectorAnimationLogo = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _logoVerticalTranslationAnimation =
        Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _vectorAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _verticalAmplitudeAnimation = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: const Interval(0.0, 1.0),
      ),
    );

    _textFadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0),
      ),
    );

    _textFadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0),
      ),
    );

    Future.delayed(const Duration(seconds: 5), navigateToNextScreen);

    _animationController.forward();
  }

  void navigateToNextScreen() async {
    // Check if the user is already logged in
    bool isLoggedIn = await checkIfUserLoggedIn();
    if (isLoggedIn) {
      // User is logged in, navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } else {
      // User is not logged in, navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnBoarding(),
        ),
      );
    }
  }

  Future<bool> checkIfUserLoggedIn() async {
    // Check the authentication state using Firebase Authentication
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0 - 10.0 * _breathe;
    return Scaffold(
      backgroundColor: const Color(0xFFF7E5B7),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              AnimatedBuilder(
                animation: _vectorAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: _vectorAnimation.value,
                    child: Transform.rotate(
                      angle: _animationController.value * 16 * pi / 180,
                      child: SizedBox(
                        child: Image.asset(
                          'assets/vector/vector3.png',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _vectorAnimationLogo,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.scale(
                          scale: _vectorAnimationLogo.value,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              _logoVerticalTranslationAnimation.value +
                                  sin(_logoAnimationController.value *
                                          pi *
                                          -1) *
                                      _verticalAmplitudeAnimation.value,
                            ),
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Image.asset('assets/logo/logo.png'),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Opacity(
                      opacity: _textFadeOutAnimation.value,
                      child: Transform(
                        transform: Matrix4.translationValues(10, -15, 0),
                        child: const Text(
                          'Welcome',
                          style: TextStyle(
                            color: Color(0xFFF7E5B7),
                            fontSize: 32,
                            fontFamily: 'Capriola',
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _textFadeInAnimation,
                      builder: (BuildContext context, Widget? child) {
                        return Opacity(
                          opacity: _textFadeInAnimation.value,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              (1 - _textFadeInAnimation.value) * 50,
                            ),
                            child: Transform(
                              transform: Matrix4.translationValues(10, -50, 0),
                              child: const Text(
                                'Craft My Plate',
                                style: TextStyle(
                                  color: Color(0xFFF7E5B7),
                                  fontSize: 32,
                                  fontFamily: 'Capriola',
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Transform(
                      transform: Matrix4.translationValues(10, -50, 0),
                      child: Opacity(
                        opacity: _textFadeInAnimation.value,
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            (1 - _textFadeInAnimation.value) * 100,
                          ),
                          child: const Text(
                            "You customize, We cater",
                            style: TextStyle(
                              color: Color.fromARGB(255, 202, 189, 159),
                              fontFamily: 'Family',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
