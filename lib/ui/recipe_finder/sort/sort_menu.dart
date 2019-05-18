import 'package:flutter/material.dart';

class SortBar extends StatefulWidget {
  final ValueChanged<String> dietChanged;
  final ValueChanged<String> healthChanged;
  final ValueChanged<String> sortChanged;
  final ValueChanged<int> calorieToChanged;
  final ValueChanged<int> calorieFromChanged;
  final String initialDiet, initialHealth, sort;
  final int calorieTo, calorieFrom;
  SortBar({this.dietChanged, this.healthChanged, this.calorieToChanged, this.calorieFromChanged, this.initialDiet, this.initialHealth, this.calorieTo, this.calorieFrom, this.sortChanged, this.sort});
  @override
  _SortBarState createState() => _SortBarState();
}

class _SortBarState extends State<SortBar> {
  String _sortBySelection = "none";
  String _dietSelection = "none";
  String _healthSelection = "none";
  TextEditingController formController, toController;

  @override
  void initState(){
    super.initState();
    _dietSelection = widget.initialDiet ?? "none";
    _healthSelection = widget.initialHealth ?? "none";
    _sortBySelection = widget.sort ?? "none";
    formController = TextEditingController(text: widget.calorieFrom != null ? widget.calorieFrom.toString() : "");
    toController = TextEditingController(text: widget.calorieTo != null ? widget.calorieTo.toString() : "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildSortBy(),
        _buildDiet(),
        _buildHealth(),
        _buildCalorieRange(),
      ],
    );
  }

  Widget _buildSortBy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Text(
              "Sort By",
              style: Theme.of(context).textTheme.display1.copyWith(fontSize: 20.0),
            )),
            SizedBox(width: 2.0),
        DropdownButton(
          value: _sortBySelection == null || _sortBySelection.isEmpty
              ? "none"
              : _sortBySelection,
          onChanged: (value) {
            setState(() {
              _sortBySelection = value;
            });
            widget.sortChanged(value);
          },
          elevation: 8,
          items: [
            DropdownMenuItem(value: "none", child: Text("None")),
            DropdownMenuItem(value: "cal", child: Text("Calories", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
            DropdownMenuItem(value: "fat", child: Text("Fat", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
          ],
        ),
      ],
    );
  }

  Widget _buildDiet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Text(
              "Diet: ",
              style: Theme.of(context).textTheme.display1.copyWith(fontSize: 20.0),
              //style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 20.0),
            )),
        SizedBox(width: 2.0),
        DropdownButton(
          value: _dietSelection == null || _dietSelection.isEmpty
              ? "none"
              : _dietSelection,
          onChanged: (value) {
            setState(() {
              _dietSelection = value;
            });
            widget.dietChanged(value);
          },
          elevation: 8,
          items: [
            DropdownMenuItem(value: "none", child: Text("None")),
            DropdownMenuItem(value: "high-protein", child: Text("High-Protein", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
            DropdownMenuItem(value: "low-carb", child: Text("Low-Carb", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
            DropdownMenuItem(value: "low-sodium", child: Text("Low-Sodium", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
          ],
        ),
      ],
    );
  }

  Widget _buildHealth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Text(
              "Health: ",
              style: Theme.of(context).textTheme.display1.copyWith(fontSize: 20.0),
            )),
        DropdownButton(
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
            DropdownMenuItem(value: "peanut-free", child: Text("Peanut-Free", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
            DropdownMenuItem(value: "vegan", child: Text("Vegan", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
            //DropdownMenuItem(value: "tree-nut-free", child: Text("Tree Nut Free")),
            DropdownMenuItem(value: "soy-free", child: Text("Soy-Free", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
            DropdownMenuItem(value: "fish-free", child: Text("Fish-Free", style: TextStyle(color: Colors.orange, fontSize: 17.0))),
          ],
        ),
      ],
    );
  }

  Widget _buildCalorieRange(){
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(children: <Widget>[
          Text("Calorie Range: ", 
          style: Theme.of(context).textTheme.display1.copyWith(fontSize: 20.0)),]),
        SizedBox(height: 5.0),
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          SizedBox(width: 10.0),
          Text("From: ", style: TextStyle(color: Colors.black54),),
          SizedBox(width: 2.0),
        Flexible(child: TextField(
          style: TextStyle(color: Colors.orange, fontSize: 15.0),
          controller: formController,
          onChanged: (str){
           widget.calorieFromChanged(str == null || str == "" ? null : int.parse(str));
         },
         onSubmitted: (str){
           widget.calorieFromChanged(str == null || str == "" ? null : int.parse(str));
         },
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration.collapsed(hintText: "", filled: true),
        )),
        SizedBox(width: 10.0),
        Text("To: ", style: TextStyle(color: Colors.black54)),
        SizedBox(width: 2.0),
        Flexible(child: TextField(
          style: TextStyle(color: Colors.orange, fontSize: 15.0),
          controller: toController,
          onChanged: (str){
           widget.calorieToChanged(str == null || str == "" ? null : int.parse(str));
         },
         onSubmitted: (str){
           widget.calorieToChanged(str == null || str == "" ? null : int.parse(str));
         },
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration.collapsed(hintText: "", filled: true)
        )),
        ],)
        
      ],
    );
  }
}