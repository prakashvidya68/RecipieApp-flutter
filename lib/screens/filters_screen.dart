import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String,bool> currentFilters;
  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenfree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

  @override
  void initState() {

    _glutenfree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetearian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.saveFilters({
                'gluten': _glutenfree,
                'vegan': _vegan,
                'lactose': _lactoseFree,
                'vegetearian': _vegetarian,
              });
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Filter Your Meal Selecion: '),
          ),
          Container(
            child: Expanded(
              child: ListView(
                children: <Widget>[
                  SwitchListTile(
                    title: Text('vegan'),
                    subtitle: Text('only include vegan food.'),
                    value: _vegan,
                    onChanged: (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('veg'),
                    subtitle: Text('only include vegetarian food.'),
                    value: _vegetarian,
                    onChanged: (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('gluten-free'),
                    subtitle: Text('only include gluten-free food.'),
                    value: _glutenfree,
                    onChanged: (newValue) {
                      setState(() {
                        _glutenfree = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('lactose-free'),
                    subtitle: Text('only include lactose-free food.'),
                    value: _lactoseFree,
                    onChanged: (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
