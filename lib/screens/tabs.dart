import 'package:acodemind03/data/dummy_data.dart';
import 'package:acodemind03/screens/filter.dart';
import 'package:acodemind03/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';
import 'categories.dart';
import 'meals.dart';

const Map<Filters, bool> KInitialFilters = {
  Filters.glutenFree : false ,
  Filters.lactoseFree : false ,
  Filters.vegetarian : false ,
  Filters.vegan : false ,
};

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filters,bool> _selectedfilters ={
    Filters.glutenFree : false ,
    Filters.lactoseFree : false ,
    Filters.vegetarian : false ,
    Filters.vegan : false ,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<void> _setScreen (String identifier) async {
    Navigator.pop(context);
     if (identifier == "filter") {
      final result = await Navigator.push< Map < Filters , bool >> (
          context,
          MaterialPageRoute(builder:
              (context) {
                return Filter(
                  currentFilters: _selectedfilters,
                );
              },
          ),
      );
      setState(() {
        _selectedfilters = result ?? KInitialFilters;
      });
     }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedfilters[Filters.glutenFree]! && !meal.isGlutenFree){
        return false ;
      }
      if (_selectedfilters[Filters.lactoseFree]! && !meal.isLactoseFree){
        return false ;
      }
      if (_selectedfilters[Filters.vegetarian]! && !meal.isVegetarian){
        return false ;
      }
      if (_selectedfilters[Filters.vegan]! && !meal.isVegan){
        return false ;
      }
      return true ;
    }).toList();
    Widget activePage = Categories(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = Meals(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}