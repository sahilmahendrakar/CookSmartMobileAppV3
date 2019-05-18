import 'package:cooksmart_v3/model/ingredient.dart';
import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:flutter/material.dart';

class IngredientForm extends StatefulWidget {
  final double elevation;
  IngredientForm({this.elevation = 2.0});
  @override
  _IngredientFormState createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _showAdd = false;
  AnimationController _controller;
  String _ingredient, _quantity, _units;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration:Duration(milliseconds: 700,),
      vsync: this
    );
    _units = "cups";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildForm(),
        _buildAdd(context),
      ],
    );
  }

  Widget _buildAdd(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    if(_showAdd){
      _controller.forward();
      return Center(child: AnimatedAdd(controller: _controller, width: width, onPressed: addPressed,));
    }
    else{
      _controller.reverse();
      return Center(child: AnimatedAdd(controller: _controller, width: width, onPressed: addPressed,));
    }
  }

  Form _buildForm(){
    return Form(
      key: formKey,
      onChanged: _handleSubmit,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Material(
                    //color: Color(0xFFfffbf5),
                    type: MaterialType.card,
                    elevation: widget.elevation,
                    borderRadius: BorderRadius.circular(30.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: TextFormField(
                        //validator: (str) => str.isEmpty || str == null ? "Enter an Ingredient" : null, 
                        onSaved: (str) => _ingredient = str,
                        onFieldSubmitted: (str) => _handleSubmit(),
                        decoration: InputDecoration.collapsed(
                          hintText: "Enter Ingredient",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                Flexible(
                  flex: 2,
                  child: Material(
                    //color: Color(0xFFfffbf5),
                    type: MaterialType.card,
                    elevation: widget.elevation,
                    borderRadius: BorderRadius.circular(30.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 5.0, 15.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              keyboardType: TextInputType.numberWithOptions(),
                              //validator: (str) => str.isEmpty || str == null ? "Enter Quantity" : null, 
                              onSaved: (str) => _quantity = str,
                              onFieldSubmitted: (str) => _handleSubmit(),
                              decoration: InputDecoration.collapsed(
                                hintText: "Quantity",
                                hintStyle: TextStyle(fontSize: 15.0,)
                              ),
                            ),
                          ),
                          Container(
                            height: 20.0,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _units,
                                onChanged: (value){
                                  setState(() {
                                    _units = value;
                                  });
                                },
                                elevation: 8,
                                items: [
                                  DropdownMenuItem(value: "cups", child: Text("cups")),
                                  DropdownMenuItem(value: "quarts", child: Text("quarts")),
                                  DropdownMenuItem(value: "tsp", child: Text("tsp")),
                                  DropdownMenuItem(value: "tbsp", child: Text("tbsp")),
                                  DropdownMenuItem(value: "grams", child: Text("grams")),
                                  DropdownMenuItem(value: "lbs", child: Text("lbs")),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

void _handleSubmit() {
    final form = formKey.currentState;
    form.save();
    if(_ingredient != null && _ingredient.isNotEmpty){
      setState(() {
        _showAdd = true;   
      });
    }
    else{
      setState(() {
        _showAdd = false;
      });
    }
  }

  void addPressed(){
    final form = formKey.currentState;
    final ingredientService = IngredientService.of(context);
    FocusScope.of(context).requestFocus(FocusNode()); //dismisses keyboard
    //form.save();
    setState(() {
      _showAdd = false;
      print(_ingredient);
      var ingredient = new Ingredient(name: _ingredient, quantity: _quantity, units: _units);
      ingredientService.addIngredient(ingredient);
    });
    form.reset();
  }


  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


}

class AnimatedAdd extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> size;
  final Animation<EdgeInsetsGeometry> padding;
  final Animation<ShapeBorder> shape;
  final Animation<double> elevation;
  final double width;
  final VoidCallback onPressed;

  AnimatedAdd({Key key, this.controller, this.width, this.onPressed}) :
    size = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 0.8,
          curve: Curves.fastOutSlowIn,
        )
      )
    ),

    padding = EdgeInsetsTween(
      begin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: EdgeInsets.fromLTRB(width/2 - 30.0, 0.0, width/2 - 30.0, 0.0)
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.8, 1.0,
          curve: Curves.fastOutSlowIn
        )
      )
    ),
    shape = ShapeBorderTween(
      begin: CircleBorder(),
      end: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.8, 1.0,
        curve: Curves.fastOutSlowIn,
      )
      )
    ),
    elevation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.7, 1.0,
          curve: Curves.fastOutSlowIn
        )
      )
    ),
    super(key: key);


  @override
  Widget build(BuildContext context) {
    //double elevation = 5.0;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child){
        return Container(
          //margin: EdgeInsets.only(bottom: 10.0),
                      child: SizeTransition(
            sizeFactor: size,
                  child: ScaleTransition(
                    scale: size,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: elevation.value < 10.0 ? 10.0 : elevation.value),
                        child: RaisedButton(
                        elevation: elevation.value,
                        highlightElevation: 0.0,
                        padding: padding.value,
                        child: Icon(Icons.add, color: Colors.white,),
                          color: Colors.green[600].withOpacity(0.7),
                          shape: shape.value,
                          onPressed: onPressed,
                        ),
                    ),
                    ),
                  ),
          ),
        );
      }
    );
  }
}