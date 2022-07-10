import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/category_model.dart';
import '../model/post_model.dart';
import '../model/product_details.dart';

class HttpData {
  // static var client = http.Client();


  Future<Welcome> fetchProducts() async {
    var response = await http.get(Uri.parse("http://fda.intertoons.com/api/V1/home"),headers: {"Authorization":"Bearer akhil@intertoons.com"});

    if (response.statusCode == 200) {
      debugPrint(response.body);
      var data = response.body;
      return welcomeFromJson(data);
    } else {
      // throw Exception();
      var data = response.body;
      return welcomeFromJson(data);
    }
  }

  Future<Category> fetchCategory() async {
    var response = await http.get(Uri.parse("http://fda.intertoons.com/api/V1/categories"),headers: {"Authorization":"Bearer akhil@intertoons.com"});

    if (response.statusCode == 200) {
      debugPrint(response.body);
      var data = response.body;
      return categoryFromJson(data);
    } else {
      // throw Exception();
      var data = response.body;
      return categoryFromJson(data);
    }
  }


  Future<PostProduct> postProduct() async {
    var response = await http.post(Uri.parse("http://fda.intertoons.com/api/V1/products"),headers: {"Authorization":"Bearer akhil@intertoons.com"},
    body: jsonEncode({

      "currentpage":1,
      "pagesize":100,
      "sortorder": {
        "field":"menu_name",
        "direction":"desc"
      },
      "searchstring":"",
      "filter":{
        "category":"{{category id}}"
      }

    }));

    if (response.statusCode == 200) {
      debugPrint(response.body);
      var data = response.body;
      return postProductFromJson(data);
    } else {
      // throw Exception();
      var data = response.body;
      return postProductFromJson(data);
    }
  }

}