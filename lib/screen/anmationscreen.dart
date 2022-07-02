import 'dart:async';
import 'package:day49_fitness_app_with_api/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    Timer(Duration(
        seconds: 3
    ), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>

        Home())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff091524),
                Color(0xffd2552c),
                Color(0xff091524),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft
          ),
        ),
        child: Column(mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Stack(
              children: [
               Image.asset("assets/logoone.png",
               height: 300,
                   width: 350,),
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: Container(
                height: 80,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text("Be Fit..",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white60
                  ),),
              ),
            ),
            SizedBox(height: 30,),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black54,
            ),
          ],
        ),
      )
    );
  }
}
