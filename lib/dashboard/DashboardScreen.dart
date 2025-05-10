import 'package:e_commerce_app/ApiService/ApiService.dart';
import 'package:e_commerce_app/dashboard/product/CategoryProductsScreen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {


  final List<Map<String, dynamic>> products = [
    {
      'title': 'Wireless Headphones',
      'price': 120.0,
      'image': 'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg'
    },
    {
      'title': 'Woman Sweater',
      'price': 120.0,
      'image': 'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg'
    }
  ];

  List<String> categories = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    fetchCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Bliss Shop", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Horizontal Categories
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(category: categories[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.orange.shade100,
                            child: const Icon(
                              Icons.category,
                              color: Colors.deepOrange,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            categories[index],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Special For You',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See all',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Product Cards
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 260,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/product', arguments: product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product['image'],
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '\$${product['price']}',
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,

        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.dashboard, color: Colors.deepOrange),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.grey),
                onPressed: () {},
              ),
              const SizedBox(width: 40), // space for the floating button
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.home, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
    );
  }


  void fetchCategoryData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedCategories = await ApiService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      // Handle error if needed
      print("Error fetching categories: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


}




