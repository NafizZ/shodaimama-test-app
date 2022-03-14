import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final String id, author, url, downloadUrl;

  const DetailScreen({ required this.id, required this.author, required  this.url, required this.downloadUrl});
  
  static Future openLink({
    required String link,
  }) => _launchUrl(link);

  static _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

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
            const Text("url: "),
            TextButton(
              child: Text(url),
              onPressed: () {
                openLink(link: url);
              }
            ),
            const Text("downloadUrl:"),
            TextButton(
              child: Text(downloadUrl),
              onPressed: () {
                openLink(link: downloadUrl);
              }
            ),
          ], 
        ),
      ),
    );
  }
}