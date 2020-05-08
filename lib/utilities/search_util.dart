import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mealz/models/meal.dart';

import 'package:http/http.dart' as http;

class MealSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Meal> sResMeals;
    bool load = true;
    sResMeals = (query.isEmpty)
        ? []
        : searchReq(query).whenComplete(() => load = false);

    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(sResMeals[index].title);
      },
      itemCount: sResMeals.length,
    );
  }

  Future<List<Meal>> searchReq(String query) async {
    List<Meal> meals = [];
    String url = "http://34.106.121.253:9200/meals/_search?q=\"$query\"";
    http.Response response = await http.get(
      url,
      headers: {
        "Authorization": "Basic dXNlcjpFOVQ2YmtGeFoyaFg=",
        "Content-Type": "application/json",
      },
    );
    var body = json.decode(response.body);
    List hits = body['hits']['hits'];
    hits.forEach((element) {
      meals.add(Meal.fromMap(element['_source']));
    });
    return meals;
  }
}
