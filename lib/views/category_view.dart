import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample1/model/post_model.dart';
import 'package:sample1/model/product_details.dart';

import '../model/category_model.dart';
import '../service/service_http.dart';
import 'cart_view.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  Welcome? productlist;
  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    productlist = await HttpData().fetchProducts();
    if(productlist != null){
      setState(() {
        isloaded = true;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return    DefaultTabController(
      length:3,
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          backgroundColor:Colors.white,
          leading: const Icon(Icons.menu,color: Colors.black,),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartView('', '', context)));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: "BEVERAGES",
              ),
              Tab(
                text: "ICECREAMS",
              ),
              Tab(
                text: "DAILYSPECIALS",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            feature(productlist),
            Center(
              child: Text("ICE CREAMS"),
            ),
            Center(
              child: Text("DAILY SPECIALS"),
            ),],
        ),
      ),
    );




    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     leading: const Icon(Icons.menu),
    //     actions: [
    //       IconButton(
    //         onPressed: () {},
    //         icon: const Icon(Icons.shopping_cart),
    //       ),
    //     ],
    //   ),
    //   body: Visibility(
    //     visible: isloaded,
    //     child: ListView.builder(
    //       itemCount: productlist?.data?.length,
    //      itemBuilder: (context, index) {
    //       return Column(
    //         children: [
    //           CachedNetworkImage(
    //             imageUrl: productlist?.data![index]?.catImg?? '',
    //             fit: BoxFit.cover,
    //           ),
    //           Text(productlist?.data![index]?.catName?? '',)
    //         ],
    //       );
    //     },),
    //     replacement: const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    // );
  }
}

Widget feature (Welcome? productlist){
  return ListView.separated(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: productlist?.data?.featuredProducts?.length?? 0,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 200,
            width: double.infinity,
            imageUrl: productlist
                ?.data?.featuredProducts![index]?.image ??
                '',
            fit: BoxFit.cover,
          ),
          Text(
            productlist?.data?.featuredProducts![index]?.name ?? '',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(productlist?.data?.featuredProducts![index]?.price ?? '',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
          ),
        ],
      );
    }, separatorBuilder: (BuildContext context, int index) {
    return SizedBox(width:10);
  },
  );
}


