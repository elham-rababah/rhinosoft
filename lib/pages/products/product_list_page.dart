import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizaaelk/model/Product.dart';
import 'package:pizaaelk/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productProvider = Provider.of(context);
    productProvider.getProducts();

    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.99,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                productProvider.itemsLoading
                    ? Center(child: const CircularProgressIndicator())
                    : productProvider.allProducts.length == 0
                    ? Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 140,
                      ),
                      Text("No Items"),
                    ],
                  ),
                )
                    : Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:  productProvider.allProducts.length,
                        itemBuilder: (BuildContext ctxt, int index) {

                          return ProductWidget(
                              product:
                              productProvider.allProducts[index]);
                        }),
                  ),
                )




              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {

  final Product product;

  const ProductWidget({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return

      InkWell(
        onTap: () {
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.deepOrangeAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(children: [
            Text(product.description??"")
          ],),
        ),
      );




  }
}



