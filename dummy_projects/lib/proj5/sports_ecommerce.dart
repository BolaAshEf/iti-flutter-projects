import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SportsECommerce extends StatefulWidget {
  const SportsECommerce({super.key});

  @override
  State<SportsECommerce> createState() => _SportsECommerceState();
}

class _SportsECommerceState extends State<SportsECommerce> {
  bool _shown = false;
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.menu),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.shop_rounded),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello", 
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Welcome to Laza", 
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20,),
            _searchBar(),
            const SizedBox(height: 20,),
            const BrandBar(brands: BrandCardModel.all,),
            const SizedBox(height: 20,),
            Expanded(child: ProductsGrid(products: ProductCardModel.all,)),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() => SizedBox(
    height: 50,
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300]
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search..",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 128, 0, 232)
          ),
          child: IconButton(onPressed: (){}, icon: const Icon(Icons.mic_outlined)),
        ),
      ],
    ),
  );
}

class BrandBar extends StatefulWidget {
  final List<BrandCardModel> brands;
  const BrandBar({super.key, required this.brands});

  @override
  State<BrandBar> createState() => _BrandBarState();
}

class _BrandBarState extends State<BrandBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text(
              "Choose Brand",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: (){},
              child: const Text("View All"),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for(final brand in widget.brands) 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BrandCard(brand: brand),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class BrandCard extends StatefulWidget {
  final BrandCardModel brand;
  const BrandCard({
    super.key,
    required this.brand,
  });

  @override
  State<BrandCard> createState() => _BrandCardState();
}

class _BrandCardState extends State<BrandCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Image.asset(widget.brand.brandImg)
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                widget.brand.brandName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandCardModel{
  static const all = [
    BrandCardModel("images/adidas-logo.png", "Adidas"),
    BrandCardModel("images/nike-logo.png", "Nike"),
    BrandCardModel("images/fila-logo.png", "Fila"),
  ];

  final String brandImg;
  final String brandName;
  const BrandCardModel(this.brandImg, this.brandName,);
}




class ProductsGrid extends StatefulWidget {
  final List<ProductCardModel> products;
  const ProductsGrid({super.key, required this.products});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text(
              "New Arraival",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: (){},
              child: const Text("View All"),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                for(final product in widget.products) 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductCard(product: product),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatefulWidget {
  final ProductCardModel product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(widget.product.img)
              ),
              IconButton(
                onPressed: () => setState(() => widget.product.loved = !widget.product.loved),
                icon: widget.product.loved ? const Icon(Icons.heart_broken) : const Icon(Icons.heart_broken_outlined),
              ),
            ],
          ),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 20
            ),
          ),
          Text(
            "${widget.product.price ~/ 1}\$",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCardModel{
  static final all = [
    ProductCardModel("images/sports-img1.jpg", "White", 99),
    ProductCardModel("images/sports-img2.jpg", "Black", 49.9),
    ProductCardModel("images/sports-img3.jpeg", "Spider - White", 150),
  ];

  final String img;
  final String name;
  bool loved;
  final double price;
  ProductCardModel(this.img, this.name, this.price, [this.loved = false]);
}