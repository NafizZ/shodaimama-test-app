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
            Text("id: $id", style: const TextStyle(fontSize: 24,),),
            Text("author: $author", style: const TextStyle(fontSize: 24,),),
            const Text("url: ", style: TextStyle(fontSize: 24,),),
            TextButton(
              child: Text(url, style: const TextStyle(fontSize: 18,),),
              onPressed: () {
                openLink(link: url);
              }
            ),
            const Text("downloadUrl:", style: TextStyle(fontSize: 24,),),
            TextButton(
              child: Text(downloadUrl, style: const TextStyle(fontSize: 18,),),
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