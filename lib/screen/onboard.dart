// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:keep_note/screen/homepage.dart';
import 'package:keep_note/models/onboard_page.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  PageController _pageController = PageController(); 
  int _currentPage = 0; 

  List<Widget> _pages = [ 
          OnBoarding(img: "assets/images/icons/splash/icon.png", title: "WelCome",subtitle: "And there you are, you now have an onboarding screen that shows the first time your app launches",),
                  OnBoarding(img: "assets/images/icons/splash/icon.png", title: "Introduce",subtitle: "And there you are, you now have an onboarding screen that shows the first time your app launches",),
                
                  OnBoarding(img: "assets/images/icons/splash/icon.png", title: "GetStart",subtitle: "And there you are, you now have an onboarding screen that shows the first time your app launches",)
  ]; 

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.white, 
        elevation: 0, 
        actions: [ 
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 12 , vertical: 20),
            child:  GestureDetector(onTap: (){ 
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())); 
             }, child: Text("Passer",style:TextStyle(color: Colors.black38 , fontSize: 16 , fontWeight: FontWeight.w500) )),
          )
        ],
      ),
      body: Stack(
        children: [ 
          PageView.builder( 
            controller: _pageController, 
            itemCount: _pages.length, 
            onPageChanged: _onchanged,
            itemBuilder: (BuildContext context, int index) { 
              return _pages[index]; 
            } 
                  
              ), 
    
              Column( 
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ 
                   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index==_currentPage)?  Color(0xff00c4d5)
                                : Colors.black38
                            
                            ));
                  })),
                ],
              )
        
        ], 
      ),
    );
  }
}