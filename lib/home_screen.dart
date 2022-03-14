import 'package:flutter/material.dart';

import 'http/http_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List _itemList = [];

  // At the beginning, we fetch the first 20 posts
  int _page = 1;
  // int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  final HttpService httpService = HttpService();

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    try {
      final response = await httpService.getData(_page);
      // for (var element in response) {
        _itemList.addAll(response);
      // }
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

   // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final response = await httpService.getData(_page);
        if (response.isNotEmpty) {
          setState(() {
              _itemList.addAll(response);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _isFirstLoadRunning = true;
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Home page'),
      ),
      body: _isFirstLoadRunning 
      ? const CircularProgressIndicator() 
      : Column(
        children: [
            Expanded(
              child: ListView.builder(
              itemCount: _itemList.length,
              controller: _controller,
              itemBuilder: (_, index) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  title: Text(_itemList[index]['id']),
                  subtitle: Text(_itemList[index]['author']),
                ),
              ),
            ),
          ),
          // when the _loadMore function is running
          if (_isLoadMoreRunning == true)
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // When nothing else to load
          if (_hasNextPage == false)
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              color: Colors.amber,
              child: const Center(
                child: Text('You have fetched all of the content'),
              ),
            ),
        ]
      ),
    );
  }
}