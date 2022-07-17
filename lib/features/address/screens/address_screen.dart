import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  final AddressServices addressServices = AddressServices();

  String addressToBeUsed = '';
  final List<PaymentItem> paymentItem = [];

  @override
  void initState() {
    super.initState();
    paymentItem.add(PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void onGpayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address!
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payButtonClicked(String addressFromProvider) {
    addressToBeUsed = '';
    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _cityController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}";
      } else {
        throw Exception("Please Enter All The Value");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackbar(context, "Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(right: 15),
                  alignment: Alignment.topLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.search,
                                color: Colors.black, size: 23),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address!.isNotEmpty)
                Column(children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                ]),
              Form(
                  key: _addressFormKey,
                  child: Container(
                    color: GlobalVariables.backgroudColor,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CustomTextField(
                          textController: _flatBuildingController,
                          hintText: "Flat, House no, Building No",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          textController: _areaController,
                          hintText: "Area, Street",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          textController: _pincodeController,
                          hintText: "Pincode",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          textController: _cityController,
                          hintText: "Town/City",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),
              GooglePayButton(
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGpayResult,
                paymentItems: paymentItem,
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 15),
                type: GooglePayButtonType.pay,
                style: GooglePayButtonStyle.black,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPressed: () => payButtonClicked(address),
              )
            ],
          ),
        ),
      ),
    );
  }
}
