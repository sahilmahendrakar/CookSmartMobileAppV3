import 'package:flutter/material.dart';

class SortBar extends StatefulWidget {
  final ValueChanged<String> dietChanged;
  final ValueChanged<String> healthChanged;
  SortBar({this.dietChanged, this.healthChanged});
  @override
  _SortBarState createState() => _SortBarState();
}

class _SortBarState extends State<SortBar> {
  String _sortBySelection = "none";
  String _dietSelection = "none";
  String _healthSelection = "none";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildSortBy(),
        _buildDiet(),
        _buildHealth()
      ],
    );
  }

  Widget _buildSortBy() {
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Text(
              "Sort By",
              style: TextStyle(fontSize: 10.0),
            )),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            value: _sortBySelection == null || _sortBySelection.isEmpty
                ? "none"
                : _sortBySelection,
            onChanged: (value) {
              setState(() {
                _sortBySelection = value;
              });
            },
            elevation: 8,
            items: [
              DropdownMenuItem(value: "none", child: Text("None")),
              DropdownMenuItem(value: "cal", child: Text("Calories")),
              DropdownMenuItem(value: "fat", child: Text("Fat")),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiet() {
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Text(
              "Diet",
              style: TextStyle(fontSize: 10.0),
            )),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            value: _dietSelection == null || _dietSelection.isEmpty
                ? "none"
                : _dietSelection,
            onChanged: (value) {
              setState(() {
                _sortBySelection = value;
              });
              widget.dietChanged(value);
            },
            elevation: 8,
            items: [
              DropdownMenuItem(value: "none", child: Text("None")),
              DropdownMenuItem(value: "high-protein", child: Text("High-Protein")),
              DropdownMenuItem(value: "low-carb", child: Text("Low-Carb")),
              DropdownMenuItem(value: "low-sodium", child: Text("Low-Sodium")),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Text(
              "Health",
              style: TextStyle(fontSize: 10.0),
            )),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            value: _healthSelection == null || _healthSelection.isEmpty
                ? "none"
                : _healthSelection,
            onChanged: (value) {
              setState(() {
                _healthSelection = value;
              });
              widget.healthChanged(value);
            },
            elevation: 8,
            items: [
              DropdownMenuItem(value: "none", child: Text("None")),
              DropdownMenuItem(value: "peanut-free", child: Text("Peanut-Free")),
              DropdownMenuItem(value: "vegan", child: Text("Vegan")),
              //DropdownMenuItem(value: "tree-nut-free", child: Text("Tree Nut Free")),
              DropdownMenuItem(value: "soy-free", child: Text("Soy-Free")),
              DropdownMenuItem(value: "fish-free", child: Text("Fish-Free")),
            ],
          ),
        ),
      ],
    );
  }
}