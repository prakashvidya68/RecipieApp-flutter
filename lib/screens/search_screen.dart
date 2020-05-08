import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:mealz/models/meal.dart';
import 'package:mealz/screens/meal_detail_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Meal> sResMeals = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FloatingSearchBar.builder(
            onChanged: (value) {
              setState(() {
                searchReq(value);
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () => Navigator.of(context).pushNamed('/meal-detail',
                        arguments: sResMeals[index].id),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(sResMeals[index].imageUrl)),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(sResMeals[index].title),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.schedule,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '${sResMeals[index].duration} min',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.attach_money,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  sResMeals[index].affordability,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
            itemCount: sResMeals.length),
      ),
    );
  }

  Future<void> searchReq(String query) async {
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
      print(element['_source']);
    });
    setState(() {
      sResMeals = meals;
    });
  }
}
