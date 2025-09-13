import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsService {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );

  // function to get all the products of a certain category
  Future<List<Map<String, dynamic>>> getAllProductsOfCategory(String category)async
  {
    final querySnapshots = await products.where('category', isEqualTo: category).get();
    final allProducts = querySnapshots.docs.map((doc) => doc.data() as Map<String, dynamic>)
      .toList();
    return allProducts;
  } 


  // function to delete a product

  // function to add a product
  Future<void> addProduct(
    String name,
    String category,
    String price,
    String description,
  ) async {
    final docRef = products.doc(name);
    final docSnapshot = await docRef.get();

    // check if there is already a product with the given name
    // if not, create a new one
    if (!docSnapshot.exists) {
      docRef.set({
        'category': category,
        'name': name,
        'price': price,
        'description': description,
      });
    }
  }

  // function to change the name of a product
  Future<void> updateProductsName(String oldName, String newName)async
  {
    final docRef = products.doc(oldName);
    await docRef.update(
      {
        'name' : newName
      }
    );
  }

  // function to change the price of a product

  Future<void> updateProductsPrice(String name, String newPrice)async
  {
    final docRef = products.doc(name);
    await docRef.update(
      {
        'price' : newPrice
      }
    );
  }

  Future<List<Map<String, dynamic>>> getAllProducts()async
  {
    final allSnapshots = await products.get();
    final allProducts = allSnapshots.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return allProducts;
  }
}
