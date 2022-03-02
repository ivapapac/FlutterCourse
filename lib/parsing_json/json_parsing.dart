import 'dart:convert';
import 'package:first_flutter_app/model/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSimple extends StatefulWidget {
  const JsonParsingSimple({Key? key}) : super(key: key);

  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  late Future<PostList> data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parsing Json"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<PostList> snapshot) {
              if (snapshot.hasData) {
                List<Post>? allPosts = snapshot.data?.posts;
                return createListView(allPosts, context);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<PostList> getData() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);
    Future<PostList> data = network.loadPosts();

    return data;
  }

  Widget createListView(List<Post>? data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(
                  height: 5.0,
                ),
                ListTile(
                  title: Text("${data?[index].title}"),
                  subtitle: Text("${data?[index].body}"),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black26,
                        radius: 23,
                        child: Text("${data?[index].id}"),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> loadPosts() async {
    Response response = await get(Uri.parse(Uri.encodeFull(url)));

    if (response.statusCode == 200) {
      return PostList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get posts!');
    }
  }
}
