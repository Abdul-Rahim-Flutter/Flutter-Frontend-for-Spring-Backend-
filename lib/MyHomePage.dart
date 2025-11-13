import 'package:flutter/material.dart';
import 'package:restful_api_practical/ApiService.dart';
import 'package:restful_api_practical/formPage.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  List<dynamic> _posts = [];
  bool _isLoading = false;
  bool _hasError = false;

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      //here we have got the posts from the api service, and stored it in posts variable
      final posts = await ApiService().fetchPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Formpage()),
          );
        },
      ),
      
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(child: Text('Error loading posts'))
          : ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return ListTile(
                  title: Text(post['title']),
                  subtitle: Text(post['body']),
                );
              },
            ),
    );
  }
}
