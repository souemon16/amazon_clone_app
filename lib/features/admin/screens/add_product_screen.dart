import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();
  final _addProductFormKey = GlobalKey<FormState>();

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && finalImages.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: nameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          category: category,
          images: finalImages);
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  String category = "Mobiles";
  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashions"
  ];

  List<File> finalImages = [];

  void selectImages() async {
    var res = await pickImage();
    setState(() {
      finalImages = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10)
                    .copyWith(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // SHOWING SLIDER OR IMAGE ADD FUNCTION
                    finalImages.isNotEmpty
                        ? CarouselSlider(
                            items: finalImages.map((i) {
                              return Builder(
                                  builder: (BuildContext context) => Image.file(
                                        i,
                                        fit: BoxFit.cover,
                                      ));
                            }).toList(),
                            options: CarouselOptions(
                                height: 200, viewportFraction: 1))
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "Select Product Images",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    CustomTextField(
                        textController: nameController,
                        hintText: "Product Name"),
                    const SizedBox(height: 10),
                    CustomTextField(
                      textController: descriptionController,
                      hintText: "Product Description",
                      maxLines: 7,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textController: priceController, hintText: "Price"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textController: quantityController,
                        hintText: "Quantity"),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: category,
                          items: productCategories.map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                          onChanged: (String? newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          }),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(text: "Sell", onTap: sellProduct)
                  ],
                ),
              )),
        ));
  }
}
