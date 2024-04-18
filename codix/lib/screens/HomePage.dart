import 'package:admob_flutter/admob_flutter.dart';
import 'package:codix/modals/provider.dart';
import 'package:codix/screens/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WordPressProvider provider;
  int activeCategoryIndex = 0;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<WordPressProvider>(context, listen: false);
    fetchData();
  }
Future<void> fetchData() async {
    await provider.fetchData();
    await provider.selectCategory(provider.categories[0]); 
  await provider.fetchPostsByCategory();
  }
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Codix News'),
        backgroundColor: const Color(0xFFFB8500),
      ),
     body: Column(
  children: [
    Expanded(
      child: Consumer<WordPressProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            itemCount: provider.posts.length,
            itemBuilder: (context, index) {
              String decodedTitle;
              try {
                decodedTitle = utf8.decode(provider.posts[index].title.runes.toList());
              } catch (e) {
                decodedTitle = provider.posts[index].title;
                print('Error decoding title at index $index: $e');
              }

              return GestureDetector(
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailPage(post: provider.posts[index]),
                      ),
                    );
                  },
                child: Card(
                  elevation: 4, 
                  margin: EdgeInsets.all(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
              
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), 
                ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        provider.posts[index].featuredMedia,
                        height: 150, 
                        fit: BoxFit.cover,
                      ),
                      Html(data: decodedTitle),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              
                        child: Text(
                          'Published on: ${provider.posts[index].date}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      
    ),
  ],
  
),
   
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Consumer<WordPressProvider>(
                builder: (context, provider, _) {
                  return ListView.builder(
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(provider.categories[index].name),
                        tileColor: activeCategoryIndex == index ?  const Color(0xFFFB8500) : null,
                        onTap: () async {
                          print('Selected category: ${provider.categories[index].name}');
                          setState(() {
                            activeCategoryIndex = index;
                          });
                          await provider.selectCategory(provider.categories[index]);
                          await provider.fetchPostsByCategory(); 
                          print('Filtered posts: ${provider.posts.length}');
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}