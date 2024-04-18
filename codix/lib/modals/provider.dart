import 'dart:convert';
import 'package:flutter/material.dart';
import 'post_model.dart';
import 'category_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class WordPressProvider extends ChangeNotifier {
  List<Post> posts = [];
  List<Category> categories = [];
  Category? selectedCategory;

  void setPosts(List<Post> newPosts) {
    posts = newPosts;
    notifyListeners();
  }

  void setCategories(List<Category> newCategories) {
    categories = newCategories;
    notifyListeners();
  }

  Future<void> selectCategory(Category category) async {
    selectedCategory = category;
    // await fetchData();
    notifyListeners();
  }

  Future<void> fetchData() async {
    await fetchPosts();
    await fetchCategories();
  }
  final String apiUrl = 'https://codix.news/wp-json/wp/v2/';

   Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('${apiUrl}posts?per_page=100'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Post> posts = await Future.wait(data.map((post) async {
        // Fetch additional details for each post
        final featuredMediaResponse =
        await http.get(Uri.parse('${apiUrl}media/${post['featured_media']}'));
    final mediaData = json.decode(featuredMediaResponse.body);
    
    // Format the date
    final date = DateTime.parse(post['date']);
    final formattedDate = DateFormat.yMd().format(date);

        return Post(
          id: post['id'],
          title: post['title']['rendered'],
          content: post['content']['rendered'],
          categories: (post['categories'] as List).map((catId) => catId.toString()).toList(),
          featuredMedia: mediaData['source_url'],
      date: formattedDate,
        );
      }));
      setPosts(posts);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse('${apiUrl}categories?per_page=100'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Category> categories = data.map((category) => Category(
        id: category['id'],
        name: category['name'],
      )).toList();
      setCategories(categories); // Use setCategories from the current instance of WordPressProvider
    } else {
      throw Exception('Failed to load categories');
    }
  }
 Future<void> fetchPostsByCategory() async {
  if (selectedCategory != null) {
    final response = await http.get(
      Uri.parse('${apiUrl}posts?categories=${selectedCategory!.id}&per_page=100'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final List<Post> posts = await Future.wait(data.map((post) async {
        // Fetch additional data for each post
        final featuredMediaResponse =
            await http.get(Uri.parse('${apiUrl}media/${post['featured_media']}'));
        final mediaData = json.decode(featuredMediaResponse.body);

        // Format the date
        final date = DateTime.parse(post['date']);
        final formattedDate = DateFormat.yMd().format(date);

        return Post(
          id: post['id'],
          title: post['title']['rendered'],
          content: post['content']['rendered'],
          categories: (post['categories'] as List).map((catId) => catId.toString()).toList(),
          // Add the 'featuredMedia' and 'date' fields to your Post model
          featuredMedia: mediaData['source_url'] as String,
          date: formattedDate,
        );
      }));

      setPosts(posts);
      print('Posts fetched successfully: ${posts.length} posts');
    } else {
      print('Failed to load posts. Status code: ${response.statusCode}');
      throw Exception('Failed to load posts');
    }
  }
}


}
