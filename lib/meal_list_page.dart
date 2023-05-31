import 'package:flutter/material.dart';
import 'api_datasource.dart';
import 'meal_model.dart';
import 'detail_meal_page.dart';

class MealListPage extends StatelessWidget {
  final String category;
  const MealListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('$category Meal'),
      )),
      body: Container(
          // padding: EdgeInsets.all(8),
          child: FutureBuilder<List<Meals>>(
        future: ApiDatasource.instance.fetchMeal(category),
        builder: (BuildContext context, AsyncSnapshot<List<Meals>> snapshot) {
          if (snapshot.hasError) return Text('error');
          if (snapshot.hasData) {
            final meals = snapshot.data!;
            print(meals);
            return _buildMeals(meals);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }

  Widget _buildMeals(meals) {
    return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (BuildContext context, int index) {
          final meal = meals[index];
          return ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Image.network(meal.strMealThumb),
            title: Text(meal.strMeal, style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailMealPage(id: meal.idMeal)));
            },
          );
        });
  }
}
