import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
   CartView(this.nameProduct, this.price,this.context ,{Key? key}) : super(key: key);
  String nameProduct;
  String price;
  BuildContext context;


   @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _drecressCounter() {
    setState(() {
      if (_counter<=0){
        return;
      }
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children:  [
            Text("ORDER SUMMARY",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Divider(thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.nameProduct,
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Text(widget.price,
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
              ],
            ),
            Row(
              children: [
                IconButton(onPressed: () {
                  _incrementCounter();
                }, icon: Icon(Icons.expand_less_outlined)),
                Text("$_counter"),
                IconButton(onPressed: () {
                  _drecressCounter();

                }, icon: Icon(Icons.expand_more_outlined)),
              ],
            ),
            Spacer(),

            SizedBox(
              width: double.infinity,
              child: Text("TOTAL",
              style: TextStyle(fontSize:30,fontWeight: FontWeight.bold ),),
            ),
            Spacer(),
            ElevatedButton(onPressed:() {},
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
            child: Text("PROCEED TO CHECKOUT"),),
            SizedBox(height:10 ,)
          ],
        ),
      ),
    );
  }
}
