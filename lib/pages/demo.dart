import 'dart:convert';
import 'package:day49_fitness_app_with_api/model/model.dart';
import 'package:day49_fitness_app_with_api/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR1GLJ073KwOsgAxkIRiZq2GnNS-Z3TROR8jpv3cwvtjpBxOSqAwphf8tpU";

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
    fetchData();
    /* Future.delayed(Duration(seconds: 3), () {

    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: allData.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.network(
                        "${allData[index].thumbnail}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 65,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${allData[index].title}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black12,
                                      Colors.black54,
                                      Colors.black87,
                                      Colors.black
                                    ])),
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
