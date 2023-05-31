import 'package:flutter/material.dart';
import 'package:flutter_application/category_model.dart';
import 'api_datasource.dart';
import 'meal_list_page.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Meal Category'),
        ),
      ),
      body: Container(
          // padding: EdgeInsets.all(8),
          child: FutureBuilder<List<Categories>>(
        future: ApiDatasource.instance.fetchData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Categories>> snapshot) {
          if (snapshot.hasError) return Text('error');
          if (snapshot.hasData) {
            final categories = snapshot.data!;
            print(categories);
            return _buildCategories(categories);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }

  Widget _buildCategories(categories) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Image.network(category.strCategoryThumb),
            title: Text(category.strCategory, style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MealListPage(category: category.strCategory)));
            },
          );
        });
  }
}
