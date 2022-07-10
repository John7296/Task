import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample1/model/product_details.dart';
import 'package:sample1/views/cart_view.dart';

import '../model/category_model.dart';
import '../service/service_http.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Welcome? productlist;
  Category? productCategory;

  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    productlist = await HttpData().fetchProducts();
    productCategory = await HttpData().fetchCategory();

    if (productlist != null) {
      setState(() {
        isloaded = true;
      });
    }
    if (productCategory != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu),
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
      ),
      body: Visibility(
        visible: isloaded,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 150.0,
                  autoPlay: true,
                ),
                itemCount: productlist?.data?.sliderBanners?.length,
                itemBuilder: (context, itemIndex, realIndex) {
                  return Container(
                    child: CachedNetworkImage(
                      imageUrl: productlist
                              ?.data?.sliderBanners![itemIndex]?.bannerImg ??
                          '',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              SizedBox(height: 20,),
              Text(
                "EXPLORE MENU",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: productCategory?.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 150,
                          imageUrl: productCategory?.data![index]?.catImg?? '',
                          fit: BoxFit.cover,
                        ),
                        Text(productCategory?.data![index]?.catName?? '',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Text(
                "FEATURED",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: productlist?.data?.featuredProducts?.length?? 0,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 200,
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
                ),
              ),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: productlist?.data?.additionalBanners?.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: CachedNetworkImage(
                      imageUrl: productlist?.data?.additionalBanners![index]?.bannerImg ?? '',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              SizedBox(height: 20,),
              Text('BEST SELLER',
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: productlist?.data?.bestsellerProducts?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: productlist?.data?.bestsellerProducts![index]?.image ?? '',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                productlist?.data?.bestsellerProducts![index]?.name ?? '',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                productlist?.data?.bestsellerProducts![index]?.price ?? '',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartView(
                                          productlist?.data?.bestsellerProducts![index]?.name ?? '',
                                          productlist?.data?.bestsellerProducts![index]?.price ?? '',
                                          context)));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            child: Text('ADD'))
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
