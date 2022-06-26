import 'dart:convert';

import 'package:day49_fitness_app_with_api/model/model.dart';
import 'package:http/http.dart' as http;


String link = "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR3KkSdSlZ6KpAuSYl2rid04O3f7LKsyt7YIArK0UtRscuzel9jzUXClGfM";
fetchAlldata()async{
  List<ExerciesModel> allData = [];
  late ExerciesModel exerciesModel;
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
        allData.add(exerciesModel);
    }
    print("total length is ${allData.length}");
  }
 return allData;
}