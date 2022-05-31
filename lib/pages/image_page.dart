import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {

    dynamic arg = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(backgroundColor: Colors.black,appBar: AppBar(backgroundColor: Colors.black,),body: Center(child: Image.network(arg.url)));
  }
}
