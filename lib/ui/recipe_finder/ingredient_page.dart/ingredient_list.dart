import 'package:cooksmart_v3/model/ingredient.dart';
import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedIngredientList extends StatefulWidget {
  final BuildContext context;
  final IngredientServiceState ingredientService;
  AnimatedIngredientList(this.context, this.ingredientService);
  @override
  _AnimatedIngredientListState createState() => _AnimatedIngredientListState();
}

class _AnimatedIngredientListState extends State<AnimatedIngredientList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  IngList<Ingredient> _list;

  @override
  void initState() {
    super.initState();
    _list = IngList<Ingredient>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
      context: widget.context,
    );
    widget.ingredientService.ingredients.addListener(_insertOnAdded);
  }

    // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
        print(index);
    return IngredientCard(
      animation: animation,
      ingredient: _list[index],
      onDelete: _remove,
    );
  }

  Widget _buildRemovedItem(
      Ingredient ingredient, BuildContext context, Animation<double> animation) {
    return IngredientCard(
      animation: animation,
      ingredient: ingredient,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  void _remove(Ingredient ingredient) {
      _list.removeAt(_list.indexOf(ingredient));
    }

  void _insertOnAdded(bool added){
    if(added) _list.insert(widget.ingredientService.ingredients.length-1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
            key: _listKey,
            initialItemCount: widget.ingredientService.ingredients.length,
            itemBuilder: _buildItem,
    );
  }

  @override
  void dispose(){
    widget.ingredientService.ingredients.removeListener(_insertOnAdded);
    super.dispose();
  }
}

class IngList<Ingredients> {
  IngList({
    @required this.listKey,
    @required this.removedItemBuilder,
    this.context,
  }){
    ingredientService = IngredientService.of(context);
    _items = ingredientService.ingredients;
  }

  IngredientServiceState ingredientService;
  final BuildContext context;
  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  IngredientList<Ingredient> _items;
  ChangeNotifier ingredientsNotifier;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index) {
    print('insert');
    _animatedList.insertItem(index);
  }

  Ingredient removeAt(int index) {
    final Ingredient removedItem = ingredientService.removeIngredient(index);
    print(_items);
    if (removedItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;

  Ingredient operator [](int index) => _items[index];

  int indexOf(Ingredient item) => _items.indexOf(item);

}

class IngredientCard extends StatelessWidget {
  IngredientCard(
      {Key key,
      @required this.ingredient,
      @required this.animation,
      this.onDelete,
      this.selected: false})
      : assert(animation != null),
        assert(selected != null),
        opacity = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        size = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final Ingredient ingredient;
  final Animation<double> animation;
  final Animation<double> opacity;
  final Animation<double> size;
  final Function onDelete;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: opacity,
        child: SizeTransition(
            sizeFactor: size,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 14.0),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            ingredient.name,
                            style: Theme.of(context).textTheme.title,
                          ))),
                  Expanded(
                      child: Center(
                          child: ingredient.quantity != null &&
                                  ingredient.quantity.isNotEmpty
                              ? Text(
                                  "${ingredient.quantity} ${ingredient.units}")
                              : Container())),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onDelete(this.ingredient),
                  )
                ]))));
  }
}

