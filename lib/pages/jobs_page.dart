import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class JobsPage extends StatefulWidget {
  JobsPage({Key key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            itemCount: 60,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: FadeInImage.memoryNetwork(
                  image: 'https://picsum.photos/id/$index/128',
                  placeholder: kTransparentImage,
                ),
              );
            }));
  }
}
