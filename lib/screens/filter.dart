import 'package:acodemind03/screens/tabs.dart';
import 'package:acodemind03/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

enum Filters {
  glutenFree ,
  lactoseFree ,
  vegetarian ,
  vegan ,
}

class Filter extends StatefulWidget {
  const Filter({super.key, required this.currentFilters});

  final Map <Filters, bool>currentFilters ;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool _glutenFreeFilterSet = false ;
  bool _lactoseFreeFilterSet = false ;
  bool _vegetarianFilterSet = false ;
  bool _veganFilterSet = false ;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filters.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filters.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filters.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filters.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters "),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier){
          if (identifier == "meal"){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return const Tabs();
                  },
              ),
            );
          }
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
           Navigator.pop(context,{
            Filters.glutenFree : _glutenFreeFilterSet ,
            Filters.lactoseFree : _lactoseFreeFilterSet ,
            Filters.vegetarian : _vegetarianFilterSet ,
            Filters.vegan : _veganFilterSet ,
          });
          return false ;
        },
        child: Column(
          children: [
            SwitchListTile(
                value: _glutenFreeFilterSet,
                onChanged: (value)=> setState(()=> _glutenFreeFilterSet = value),
                title:Text(
                  "Gluten-free",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                ),
              subtitle: Text(
                  "Only include Gluten-free meals.",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
                value: _lactoseFreeFilterSet,
                onChanged: (value)=> setState(()=> _lactoseFreeFilterSet = value),
                title:Text(
                  "Lactose-free",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                ),
              subtitle: Text(
                  "Only include Lactose-free meals.",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
                value: _vegetarianFilterSet,
                onChanged: (value)=> setState(()=> _vegetarianFilterSet = value),
                title:Text(
                  "Vegetarian",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                ),
              subtitle: Text(
                  "Only include vegetarian meals.",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
                value: _veganFilterSet,
                onChanged: (value)=> setState(()=> _veganFilterSet = value),
                title:Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                ),
              subtitle: Text(
                  "Only include Vegan meals.",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
