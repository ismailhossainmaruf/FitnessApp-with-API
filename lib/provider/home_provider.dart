

import 'package:day49_fitness_app_with_api/data_fetch/fetch_data.dart';
import 'package:day49_fitness_app_with_api/model/model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier{
  List<ExerciesModel> allData = [];
  getHomepageData()async{
    allData= await fetchAlldata();
    notifyListeners();
  }

}