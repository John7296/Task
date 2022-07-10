import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample1/model/post_model.dart';

import '../service/service_http.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  PostProduct? productlist;
  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    productlist = await HttpData().postProduct();
    if(productlist != null){
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Visibility(
        visible: isloaded,
        child: ListView.builder(
          itemCount: productlist?.data!.products!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl: productlist?.data!.products![index]?.image?? '',
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                Text(productlist?.data!.products![index]?.name?? '',
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
              ],
            );
          },),

        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
