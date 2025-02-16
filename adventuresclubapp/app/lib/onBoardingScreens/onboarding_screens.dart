import 'dart:async';
import 'package:app/constants.dart';
import 'package:app/sign_up/Sign_up.dart';
import 'package:app/sign_up/sign_in.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController _pageViewController = PageController(initialPage: 0);
  int _activePage = 0;
  int index = 0;
  int currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        if (_activePage < 4) {
          _activePage++;
        } else {
          _activePage = 0;
        }
        _pageViewController.animateToPage(
          _activePage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController
    _timer.cancel();
  }

  void goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SignUp();
        },
      ),
    );
  }

  List<Widget> pages = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter:
                ColorFilter.mode(blackColor.withOpacity(0.4), BlendMode.darken),
            image: const ExactAssetImage('images/climb.png'),
            fit: BoxFit.cover),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Adventures Club',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
              child: Text(
                  'Find adventure near you, connect with cool people, and get outside.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    height: 1.3,
                    fontFamily: 'Raleway',
                  )),
            ),
            SizedBox(height: 2)
          ],
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
            colorFilter:
                ColorFilter.mode(blackColor.withOpacity(0.4), BlendMode.darken),
            image: const ExactAssetImage('images/freerider.png'),
            fit: BoxFit.cover),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Adventures Club',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Life is ...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.3,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  Text(
                    'Crazy, busy and messy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.3,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2)
          ],
        ),
      ),
    ),
    Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  blackColor.withOpacity(0.4), BlendMode.darken),
              image: const ExactAssetImage('images/picture1.png'),
              fit: BoxFit.cover),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Adventures Club',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
                child: Column(
                  children: [
                    Text('Lets get back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          height: 1.3,
                          fontFamily: 'Raleway',
                        )),
                    Text('to the moment that matter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          height: 1.3,
                          fontFamily: 'Raleway',
                        )),
                  ],
                ),
              ),
              SizedBox(height: 2)
            ],
          ),
        )),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  blackColor.withOpacity(0.4), BlendMode.darken),
              image: const ExactAssetImage('images/man.png'),
              fit: BoxFit.cover)),
      child: const Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Adventures Club',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
              child: Column(
                children: [
                  Text('Spending time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        height: 1.3,
                        fontFamily: 'Raleway',
                      )),
                  Text(
                    'Outdoors',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.3,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2)
          ],
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  blackColor.withOpacity(0.4), BlendMode.darken),
              image: const ExactAssetImage('images/swimming.png'),
              fit: BoxFit.cover)),
      child: const Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Adventures Club',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
              child: Column(
                children: [
                  Text('Create real human',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        height: 1.3,
                        fontFamily: 'Raleway',
                      )),
                  Text(
                    'connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.3,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2)
          ],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: PageView.builder(
                  controller: _pageViewController,
                  onPageChanged: (index) {
                    setState(() {
                      _activePage = index;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return pages[index];
                  }),
            ),
            Positioned(
              bottom: 50,
              right: 40,
              child: Button(
                  'Get Started',
                  whiteColor,
                  whiteColor,
                  blackColor,
                  18,
                  goToSignUp,
                  Icons.add,
                  whiteColor,
                  false,
                  1.3,
                  'Raleway',
                  FontWeight.w600,
                  16),
            ),
            Positioned(
              bottom: 15,
              left: 75,
              child: GestureDetector(
                onTap: () {
                  context.push('/signIn');

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (_) {
                  //       return const SignIn();
                  //     },
                  //   ),
                  // );
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Already have an account ?',
                          style: TextStyle(
                            color: whiteColor,
                            fontFamily: 'Raleway',
                          )),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
