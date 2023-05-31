import 'dart:convert';
import 'package:http/http.dart' as http;
import 'category_model.dart';
import 'meal_model.dart';
import 'detail_meal_model.dart';

class ApiDatasource {
  static ApiDatasource instance = ApiDatasource();

  Future<List<Categories>> fetchData() async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['categories'];
      return results.map((item) => Categories.fromJson(item)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Meals>> fetchMeal(category) async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['meals'];
      return results.map((item) => Meals.fromJson(item)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<DetailMeals>> detailMeal(id) async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['meals'];
      return results.map((item) => DetailMeals.fromJson(item)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }
}
