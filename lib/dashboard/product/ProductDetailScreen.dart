import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/dashboard/cart/CartScreen.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isAddedToCart = false;
  int _selectedTabIndex = 0;

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
      body: SingleChildScrollView(
      child: Stack(
        children:  [
          Column(
          children: [
            const SizedBox(height: 40),

            // Product Image
            Container(
              margin: EdgeInsets.only(top: 40),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  viewportFraction: 0.98,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                ),
                items: [
                  // Discount Banner 1
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      image: DecorationImage(
                        image: NetworkImage(product['image']),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Add more items as needed
                ],
              ),
            ),

            SizedBox(height: 20),
            // Product Title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 180,
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

                            Text(
                              '\$${product['price']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),

                            // Rating UI
                            Row(
                              children: [
                                // Star Rating
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 65,
                                  height: 25,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      // Rating Number
                                      Text(
                                        product['rating']['rate'].toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 4),
                                // Review Count
                                Text(
                                  '(${product['rating']['count']} Review)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Text(
                                'Seller: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const Text(
                                'Tariqul Islam',
                                style: TextStyle(
                                  fontSize: 14,fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Horizontal scrollable color list
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildColorCircle(Colors.brown),
                            _buildColorCircle(Colors.green),
                            _buildColorCircle(Colors.blue),
                            _buildColorCircle(Colors.black),
                            _buildColorCircle(Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),


                  // Tabs description specification reviews
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Description Tab
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 0
                                ? Colors.orange
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 14,
                              color: _selectedTabIndex == 0
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: _selectedTabIndex == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),

                      // Specification Tab
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 1
                                ? Colors.orange
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Specification',
                            style: TextStyle(
                              fontSize: 14,
                              color: _selectedTabIndex == 1
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: _selectedTabIndex == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),

                      // Reviews Tab
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = 2;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 2
                                ? Colors.orange
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 14,
                              color: _selectedTabIndex == 2
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: _selectedTabIndex == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Add this to show the corresponding content
                  IndexedStack(
                    index: _selectedTabIndex,
                    children: [
                      // Description Content
                      _selectedTabIndex == 0
                          ? SizedBox(
                            height: 80,
                            child: Text(
                                product['description'],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade600),
                              ),
                          )
                          : Container(),

                      // Specification Content
                      _selectedTabIndex == 1
                          ? SizedBox(
                            height: 80,
                            child: Text(
                                'Specifications will appear here',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                          )
                          : Container(),

                      // Reviews Content
                      _selectedTabIndex == 2
                          ? SizedBox(
                            height: 80,
                            child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        product['rating']['rate'].toString(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 8),
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 24),
                                      Text(
                                        ' (${product['rating']['count']} reviews)',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  // Add your review list here
                                ],
                              ),
                          )
                          : Container(),
                    ],
                  ),


                  const SizedBox(height: 150),
                ],
              ),
            ),
          ],
        ),

          /// arrow back, share , favorite
          Positioned(
            top: 20,
            left: 8,
            right: 8,
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: const Icon(
                        size: 15,
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
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
                          decoration: BoxDecoration(
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
                          decoration: BoxDecoration(
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
              ],
            ),
          ),

          // Add to Cart Button
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Decrement Button
                            IconButton(
                              onPressed: _decrementQuantity,
                              icon: const Icon(Icons.remove, size: 18, color: Colors.white),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              splashRadius: 20,
                            ),

                            // Quantity Display
                            Container(
                              width: 30, // Fixed width for number display
                              alignment: Alignment.center,
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Increment Button
                            IconButton(
                              onPressed: _incrementQuantity,
                              icon: const Icon(Icons.add, size: 18, color: Colors.white),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              splashRadius: 20,
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
                          // Check if the product already exists in the cart
                          int existingIndex = cartItems.indexWhere((item) => item['id'] == product['id']);

                          if (existingIndex != -1) {
                            // Product exists, update the quantity
                            setState(() {
                              cartItems[existingIndex]['quantity'] += _quantity;
                            });
                          } else {
                            // Product doesn't exist, add new item
                            cartItems.add({
                              'id': product['id'],
                              'title': product['title'],
                              'category': product['category'],
                              'price': product['price'],
                              'image': product['image'],
                              'description': product['description'],
                              'quantity': _quantity,
                            });
                          }

                          // Show confirmation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(existingIndex != -1
                                  ? 'Quantity updated in cart!'
                                  : 'Added to cart!'),
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ]),
              ),
    );
  }
}

Widget _buildColorCircle(Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300),
    ),
  );
}

