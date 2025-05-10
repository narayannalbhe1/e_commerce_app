import 'package:e_commerce_app/dashboard/cart/CartScreen.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isAddedToCart = false;

  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _toggleCartStatus() {
    setState(() {
      _isAddedToCart = !_isAddedToCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: ListView(
        children: [
          // Product Image
          Stack(
            children: [
              Padding(
              padding: const EdgeInsets.only(top: 80.0,left: 16,right: 16),
              child: Center(
                child: Image.network(
                  product['image'],
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.fill,
                ),
              ),
            ),

              Positioned(
                top: 10,
                left: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: const Icon(
                        size: 20,
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 16,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100,
                          ),
                          child: const Icon(
                            size: 20,
                            Icons.share,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100,
                          ),
                          child: const Icon(
                            size: 20,
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
          ]
          ),
          const SizedBox(height: 16),

          // Product Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  product['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 4),
                // Rating UI
                Row(
                  children: [
                    // Star Rating
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < product['rating']['rate'].floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                    SizedBox(width: 4),
                    // Rating Number
                    Text(
                      product['rating']['rate'].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(width: 4),
                    // Review Count
                    Text(
                      '(${product['rating']['count']})',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Product Description
                Text(
                  product['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                // Product Price
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                // Add to Cart Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Quantity Selector
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Decrement Button
                                IconButton(
                                  onPressed: _decrementQuantity,
                                  icon: const Icon(Icons.remove, color: Colors.white),
                                ),
                                // Quantity Display
                                Text(
                                  '$_quantity',
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                // Increment Button
                                IconButton(
                                  onPressed: _incrementQuantity,
                                  icon: const Icon(Icons.add, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Custom Add to Cart Button
                        // In your ProductDetailScreen's build method
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () {
                              // Add the product to cartItems with the selected quantity
                              cartItems.add({
                                'id': product['id'],
                                'title': product['title'],
                                'price': product['price'],
                                'image': product['image'],
                                'description': product['description'],
                                'quantity': _quantity,
                              });

                              // Show confirmation
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added to cart!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              // Navigate to cart screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: const Center(
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),



        ],
      ),
    );
  }
}
