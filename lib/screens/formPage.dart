import 'package:flutter/material.dart';
import 'package:taskmanager_client/services/ApiService.dart';
import 'package:taskmanager_client/models/ErrorResponse.dart';

class Formpage extends StatefulWidget {
  const Formpage({super.key});

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  bool _isSubmitting = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  Future<void> _submitPost() async {
    setState(() {
      _isSubmitting = true;
    });
    try {
      await ApiService().createPost(
        //title
        _titleController.text,
        //body
        _bodyController.text,
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });

      final message= e is ErrorResponse ? e.message : 'An error occurred';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(label: Text('Title')),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(label: Text('Body')),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            _isSubmitting
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: _submitPost, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
