class Ingredient{
  final String name;
  final String quantity;
  final String units;

  Ingredient({this.name, this.quantity, this.units});

  @override
  String toString(){
    return("$name, $quantity $units|");
  }
}