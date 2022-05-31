import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {

    dynamic arg = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Images"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width ,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                image: DecorationImage(
                    image: NetworkImage(arg.url),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.favorite,color: Colors.red,),
                    const SizedBox(height: 2,),
                    Text(arg.likes.toString()),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.download,color: Colors.black,),
                    const SizedBox(height: 2,),
                    Text(arg.downloads.toString()),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.share,color: Colors.black,),
                    SizedBox(height: 2,),
                    Text("5896"),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.add_box,color: Colors.black,),
                    SizedBox(height: 2,),
                    Text("Save"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15,),
            const Divider(height: 2,color: Colors.grey,),
            const SizedBox(height: 5,),
            ListTile(
              leading: CircleAvatar(radius: 25,backgroundImage: NetworkImage(arg.userImageUrl),),
              title: Text(arg.userName),
              subtitle: Text(arg.size.toString()),
              trailing: TextButton(onPressed: (){},child: const Text("Follow",style: TextStyle(fontSize: 18),),),
            ),
            const SizedBox(height: 5,),
            const Divider(height: 2,color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
