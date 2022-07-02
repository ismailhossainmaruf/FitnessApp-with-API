import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:day49_fitness_app_with_api/model/model.dart';
import 'package:day49_fitness_app_with_api/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LastPage extends StatefulWidget {
  LastPage({Key? key,this.exerciesModel,this.second}) : super(key: key);
  ExerciesModel? exerciesModel;
  int? second;
  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  double seceond =3;
  AudioPlayer audioPlayer =AudioPlayer();
  AudioCache audioCache = AudioCache();
  Timer ?timer;
  bool isComplete = false;
  String path = "audio.mp3";
  int ?Startsound=0;

  playAudio()async{
    await audioCache.play(path);
    print("$audioCache donee");
  }
  
  @override
  void initState() {
    // TODO: implement initState
    timer= Timer.periodic(Duration(
      seconds: 2,
    ), (timer) {
      if (timer.tick==widget.second){
        timer.cancel();
        setState(() {
          isComplete=true;
          playAudio();
          Future.delayed(Duration(seconds: 3),(){
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        Startsound=timer.tick;
      });
    });
    Provider.of<HomeProvider>(context,listen: false).getHomepageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff091524),
        centerTitle: true,
        title:  Text("${widget.exerciesModel!.title}"),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff091524),

                Color(0xff091524),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network("${widget.exerciesModel!.gif}",
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.all(8.0),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black26,
                ),
                alignment: Alignment.center,
                child: Text("${widget.exerciesModel!.title}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),)),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                  margin: EdgeInsets.all(8.0),
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black26,
                  ),
                  alignment: Alignment.center,
                  child: Text("${Startsound} / ${widget.second} s",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),)),
            ),

          ],
        ),
      ),
    );
  }
}
