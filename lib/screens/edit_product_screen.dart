import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = 'edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _formImage = GlobalKey<FormState>();
  var _product = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  Future<void> _saveForm() async {
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState!.validate();
    setState(() {
      _hasImage = _product.imageUrl.isNotEmpty;
    });
    if (isValid && _hasImage) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      if (_product.id.isEmpty) {
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_product);
        } catch (error) {
          await showDialog<Null>(
            context: (context),
            builder: (ctx) => AlertDialog(
              title: const Text('Xatolik!'),
              content: const Text('Maxsulot qo\'shishda xatolik'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
        }
        // finally {
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   Navigator.of(context).pop();
        // }
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .updateProduct(_product);
        } catch (e) {
          await showDialog<Null>(
            context: (context),
            builder: (ctx) => AlertDialog(
              title: const Text('Xatolik!'),
              content: const Text('Maxsulot qo\'shishda xatolik'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
        }
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  void _saveImageForm() {
    final isValid = _formImage.currentState!.validate();
    if (isValid) {
      _formImage.currentState!.save();
      setState(() {
        _hasImage = true;
      });
      Navigator.of(context).pop();
    }
  }

  var _init = true;
  var _hasImage = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null && productId is String) {
        final editingProduct =
            Provider.of<Products>(context).findById(productId);
        _product = editingProduct;
      }
    }
    _init = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Rasm URL-ni kiriting'),
          content: Form(
            key: _formImage,
            child: TextFormField(
              initialValue: _product.imageUrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, rasm URL-ni kiriting';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Rasm URL', border: OutlineInputBorder()),
              keyboardType: TextInputType.url,
              onSaved: (newValue) {
                _product = Product(
                  id: _product.id,
                  title: _product.title,
                  description: _product.description,
                  price: _product.price,
                  imageUrl: newValue!,
                  isFavorite: _product.isFavorite,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Bekor qilish'),
            ),
            ElevatedButton(
              onPressed: _saveImageForm,
              child: const Text('Saqlash'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Maxsulot qo\'shish'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save)),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _product.title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, maxsulot nomini kiriting';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nomi',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        onSaved: (newValue) {
                          _product = Product(
                            id: _product.id,
                            title: newValue!,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                            isFavorite: _product.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _product.price.toStringAsFixed(2),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, maxsulot narxini kiriting';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Narxi',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSaved: (newValue) {
                          _product = Product(
                            id: _product.id,
                            title: _product.title,
                            description: _product.description,
                            price: double.parse(newValue!),
                            imageUrl: _product.imageUrl,
                            isFavorite: _product.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _product.description,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, maxsulot ma\'lumotlarini kiriting';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Qo\'shimcha ma\'lumotlar',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true),
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        onSaved: (newValue) {
                          _product = Product(
                            id: _product.id,
                            title: _product.title,
                            description: newValue!,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                            isFavorite: _product.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                              color: Colors.grey,
                            )),
                        child: InkWell(
                          onTap: () => _showImageDialog(context),
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(5),
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: _product.imageUrl.isEmpty
                                ? const Text('Asosiy rasm URL-ni kiriting')
                                : Image.network(
                                    _product.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
