import 'package:flutter/material.dart';
import 'package:imageapi/helper/helperclass.dart';
import 'package:imageapi/pages/detail_page.dart';
import 'package:imageapi/pages/image_page.dart';

import 'models/image_model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes:{
      "/": (context) => const HomePage(),
      "image_page": (context) => const ImagePage(),
      "detail": (context) => const DetailPage(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    APIHelper.apiHelper.fetchImagesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Images"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      onSubmitted: (val) {
                        setState(() {
                          APIHelper.apiHelper.search = val;
                        });
                        Navigator.of(context).pushReplacementNamed("/");
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: APIHelper.apiHelper.search),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 10,
            child: FutureBuilder(
              future: APIHelper.apiHelper.fetchImagesData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  List<Images> allDetails = snapshot.data;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed("image_page",arguments: allDetails[i]);
                          },
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(allDetails[i].url),
                                  fit: BoxFit.cover),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      allDetails[i].views.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const Spacer(),
                                    PopupMenuButton(
                                      icon: const Icon(Icons.more_vert,color: Colors.white,),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                              child: TextButton(onPressed: (){Navigator.of(context).pushNamed("detail",arguments: allDetails[i]);},child:const Text("More Details",style: TextStyle(color: Colors.black),))),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      allDetails[i].likes.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      allDetails[i].downloads.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(width: 5,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: allDetails.length,
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.grey,
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
