import 'package:flutter/material.dart';
import 'detail_meal_model.dart';
import 'api_datasource.dart';

class DetailMealPage extends StatelessWidget {
  final String id;
  const DetailMealPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Meal Detail'),
      )),
      body: SingleChildScrollView(
          // padding: EdgeInsets.all(8),
          child: FutureBuilder<List<DetailMeals>>(
        future: ApiDatasource.instance.detailMeal(id),
        builder:
            (BuildContext context, AsyncSnapshot<List<DetailMeals>> snapshot) {
          if (snapshot.hasError) return Text('error');
          if (snapshot.hasData) {
            final meals = snapshot.data!;
            print(meals);
            return _buildDetailMeal(meals);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }

  Widget _buildDetailMeal(meals) {
    return Center(
      child: Column(
        children: [
          Text(meals[0].strMeal),
          Image.network(meals[0].strMealThumb),
          Text(meals[0].strCategory),
          Text(meals[0].strArea),
          Text(meals[0].strTags),
          Text(meals[0].strYoutube),
        ]
        ),
    );
  }
}
