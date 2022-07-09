import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got/Models/CharactersInfoResponse.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Network/api_client.dart';
import 'Styles/AppTheme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() {
    setState(() {
    });
  }

  FutureBuilder<List<CharactersInfoResponse>> _getCharacters(BuildContext context) {

    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<List<CharactersInfoResponse>>(

      future: client.getCharacters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<CharactersInfoResponse>? posts = snapshot.data;
          return _buildCharacterList(context, posts!);
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.brown,
              // backgroundColor: Colors.white,
            ),
          );
        }
      },
    );
  }

  ListView _buildCharacterList(BuildContext context, List<CharactersInfoResponse> list) {

    return ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ArticlePage(article: list![index],)),
            // );
          },
          child: Card(
            color: Colors.white,
            elevation: 8,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    child: Row(
                      children: [
                        FadeInImage.memoryNetwork(
                          image: list[index].imageUrl.toString(),
                          width: 130,
                          height: 130,
                          placeholder: kTransparentImage,
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return Image.asset(
                                'assets/images/flag_placeholder.jpg',
                                width: 130,
                                height: 130,
                                fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Column(children: [
                          Row(children: [Expanded(child: Text("Name: ${list[index].fullName}", style: AppTheme.titleText, textAlign: TextAlign.left,))],),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [Expanded(child: Text("Title: ${list[index].title}", style: AppTheme.subtitleText, textAlign: TextAlign.left,))],),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [Expanded(child: Text("Family: ${list[index].family}", style: AppTheme.subtitleText, textAlign: TextAlign.left,))],),
                          const SizedBox(
                            height: 10,
                          ),
                        ],))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [

        ],
      ),
      body: _getCharacters(context),

      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}