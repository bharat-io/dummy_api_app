import 'package:api_testing_app/api_service.dart';
import 'package:api_testing_app/model/carts_model.dart';
import 'package:api_testing_app/util/app_contant.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Carts"),
      ),
      body: FutureBuilder<CartsModel?>(
        future: apiService.getData<CartsModel>(
          url: "${AppContant.baseUrl}/carts",
          fromjson: (json) => CartsModel.fromjson(json),
        ),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapShot.hasError) {
            return Center(child: Text("Error: ${snapShot.error}"));
          } else if (snapShot.hasData) {
            final carts = snapShot.data!.carts;

            return ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index) {
                final cart = carts[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 4,
                  child: ExpansionTile(
                    title:
                        Text("Cart ID: ${cart.id} | User ID: ${cart.userId}"),
                    subtitle: Text(
                        "Total: ₹${cart.total} | Discounted: ₹${cart.discountedTotal}"),
                    children: cart.products.map((product) {
                      return ListTile(
                        leading: Image.network(
                          product.thumbnail,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title),
                        subtitle: Text(
                            "Qty: ${product.quantity} | Price: ₹${product.price}"),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Total: ₹${product.total}"),
                            Text("Discounted: ₹${product.discountedTotal}"),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No data found."));
        },
      ),
    );
  }
}
