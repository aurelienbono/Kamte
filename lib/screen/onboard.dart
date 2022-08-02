// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:keep_note/screen/homepage.dart';
import 'package:keep_note/screen/view_onboard/list_view.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return PageView( 
        children: [ 
         Welcome() , 
         IntroducePage() , 
         GetStarter(), 
        ],
    );
  }
}