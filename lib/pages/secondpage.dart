import 'package:day49_fitness_app_with_api/model/model.dart';
import 'package:day49_fitness_app_with_api/pages/thirdpage.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SecondUi extends StatefulWidget {
   SecondUi({Key? key,this.exerciesModel}) : super(key: key);
  ExerciesModel? exerciesModel;
  @override
  State<SecondUi> createState() => _SecondUiState();
}

class _SecondUiState extends State<SecondUi> {

  List<ExerciesModel> allData = [];
  late ExerciesModel exerciesModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff091524),
        centerTitle: true,
        title:  Text("${widget.exerciesModel!.title}"),
      ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff091524),
               //  Color(0xffffccbc),
                  Color(0xff091524),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft
            ),
          ),
          child: Stack(
          children: [
            Image.network("${widget.exerciesModel!.thumbnail}",
              // color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            fit: BoxFit.cover,),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
                  children: [
                        SleekCircularSlider(
                    innerWidget: (value){
                        return Container(
                          alignment: Alignment.center,
                          child: Text("${second.toStringAsFixed(0)}s",
                          style: TextStyle(
                            color: Colors.white
                          ),),
                        );
                    },
                        appearance: CircularSliderAppearance(),
                        min: 3,
                        max: 30,
                        initialValue: second,

                        onChange: (value) {
                        setState(() {
                          second=value;
                        });
                          print(value);
                        }),
                    MaterialButton(onPressed: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        LastPage(
                          exerciesModel: widget.exerciesModel,
                            second: second.toInt(),

                        )));
                      });
                    },minWidth: 350,
                        color: Colors.red,
                        elevation: 0,
                        hoverColor: Colors.transparent,
                        child: Text("Start",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),)),
                      ],
                ),
              ),

            ),

          ],
      ),
        ),
    );
  }
  double second =3;
}
