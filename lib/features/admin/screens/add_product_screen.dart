import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/custom_textfield.dart';
import 'package:tijaramart/constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productQuantityController = TextEditingController();

  List<String> productCategories = ["Mobile", "Clothes", "Appliances", "Foods"];
  String selectedCategory = "Mobile";
  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Center(
              child: Text(
                "Add Product",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10.0),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.folder_open_outlined,
                        size: 40.0,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Upload Product Image",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                editingController: _productNameController,
                hintText: "Product Name",
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextField(
                editingController: _productDescriptionController,
                hintText: "Product Description",
                maxLines: 5,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextField(
                editingController: _productPriceController,
                hintText: "Product Price",
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextField(
                editingController: _productQuantityController,
                hintText: "Product Quantity",
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                    isExpanded: true,
                    value: selectedCategory,
                    icon: const Icon(Icons.arrow_circle_down),
                    items: productCategories.map((String productItem) {
                      return DropdownMenuItem(
                        value: productItem,
                        child: Text(productItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
