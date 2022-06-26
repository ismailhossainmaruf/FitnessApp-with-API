import 'dart:convert';

import 'package:day49_fitness_app_with_api/model/model.dart';
import 'package:day49_fitness_app_with_api/pages/secondpage.dart';
import 'package:day49_fitness_app_with_api/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String link = "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR3KkSdSlZ6KpAuSYl2rid04O3f7LKsyt7YIArK0UtRscuzel9jzUXClGfM";
  List<ExerciesModel> allData = [];
  late ExerciesModel exerciesModel;

  bool isLoading = false;

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    var responce = await http.get(Uri.parse(link));
    print("status code is ${responce.statusCode}");
    print("${responce.body}");
    if (responce.statusCode == 200) {
      final item = jsonDecode(responce.body);
      for (var data in item["exercises"]) {
        exerciesModel = ExerciesModel(
            id: data["id"],
            gif: data["gif"],
            seconds: data["seconds"],
            thumbnail: data["thumbnail"],
            title: data["title"]);
        setState(() {
          allData.add(exerciesModel);
        });
      }

      print("total length is ${allData.length}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<HomeProvider>(context,listen: false).getHomepageData();
    fetchData();
    /* Future.delayed(Duration(seconds: 3), () {

    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff091524),
        centerTitle: true,
        title: Text("Fitness App"),
      ),
      body: Container(
       // margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff091524),
               // Color(0xffd2552c),
                Color(0xff091524),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: allData.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondUi(
                      exerciesModel: allData[index],
                    )));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.network("${allData[index].thumbnail}",width: double.infinity,
                      fit: BoxFit.cover,),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.all(16),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.transparent
                          ),
                          child: Text("${allData[index].title}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
