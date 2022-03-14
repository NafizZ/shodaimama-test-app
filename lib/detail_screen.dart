import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String id, author, url, downloadUrl;

  const DetailScreen({ required this.id, required this.author, required  this.url, required this.downloadUrl});
  
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("id: $id"),
            Text("author: $author"),
            Text("url: $url"),
            Text("downloadUrl: $downloadUrl"),
          ], 
        ),
      ),
    );
  }
}