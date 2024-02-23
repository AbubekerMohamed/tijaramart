import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/custom_textfield.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/address/services/address_services.dart';
import 'package:tijaramart/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "address-screen";
  final String totalAmount;
  const AddressScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _adressFormKey = GlobalKey<FormState>();
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final AddressServices _addressServices = AddressServices();
  final List<PaymentItem> _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  String addressToUse = '';

  final String defaultApplePayConfigString = """{
    "provider": "apple_pay",
    "data": {
      "merchantIdentifier": "merchant.com.sams.fish",
      "displayName": "Sam's Fish",
      "merchantCapabilities": ["3DS", "debit", "credit"],
      "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
      "countryCode": "US",
      "currencyCode": "USD",
      "requiredBillingContactFields": ["post"],
      "requiredShippingContactFields": ["post", "phone", "email", "name"],
      "shippingMethods": [
        {
          "amount": "0.00",
          "detail": "Available within an hour",
          "identifier": "in_store_pickup",
          "label": "In-Store Pickup"
        },
        {
          "amount": "4.99",
          "detail": "5-8 Business Days",
          "identifier": "flat_rate_shipping_id_2",
          "label": "UPS Ground"
        },
        {
          "amount": "29.99",
          "detail": "1-3 Business Days",
          "identifier": "flat_rate_shipping_id_1",
          "label": "FedEx Priority Mail"
        }
      ]
    }
  }""";

  final String defaultGooglePayConfigString = """{
    "provider": "google_pay",
    "data": {
      "environment": "TEST",
      "apiVersion": 2,
      "apiVersionMinor": 0,
      "allowedPaymentMethods": [
        {
          "type": "CARD",
          "tokenizationSpecification": {
            "type": "PAYMENT_GATEWAY",
            "parameters": {
              "gateway": "example",
              "gatewayMerchantId": "gatewayMerchantId"
            }
          },
          "parameters": {
            "allowedCardNetworks": ["VISA", "MASTERCARD"],
            "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
            "billingAddressRequired": true,
            "billingAddressParameters": {
              "format": "FULL",
              "phoneNumberRequired": true
            }
          }
        }
      ],
      "merchantInfo": {
        "merchantId": "01234567890123456789",
        "merchantName": "Example Merchant Name"
      },
      "transactionInfo": {
        "countryCode": "US",
        "currencyCode": "USD"
      }
    }
  }""";

  void payPressed(String addressFromProvider) {
    addressToUse = "";
    bool isFormFilled = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;
    if (isFormFilled) {
      if (_adressFormKey.currentState!.validate()) {
        addressToUse =
            '${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}';
      } else {
        throw Exception("Please insert all fields");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToUse = addressFromProvider;
    } else {
      showSnackBar(context, "Insert your address");
      throw Exception("Please insert all fields");
    }
  }

  void onGooglePayResult(res) {
    if (context.watch<UserProvider>().user.address.isEmpty) {
      _addressServices.saveUserAddress(context: context, address: addressToUse);
    }
  }

  void onApplePayResult(res) {}

  @override
  void initState() {
    super.initState();
    _paymentItems.add(PaymentItem(
      amount: widget.totalAmount,
      label: "Total Amount",
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _adressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      editingController: _flatBuildingController,
                      hintText: "Flat House Number Building",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      editingController: _areaController,
                      hintText: "Area Street",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      editingController: _pincodeController,
                      hintText: "Pincode",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      editingController: _cityController,
                      hintText: "Town/City",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ApplePayButton(
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                    defaultApplePayConfigString),
                paymentItems: _paymentItems,
                style: ApplePayButtonStyle.black,
                type: ApplePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onApplePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                width: double.infinity,
                height: 50,
                onPressed: () => payPressed(address),
              ),
              GooglePayButton(
                onPressed: () => payPressed(address),
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                    defaultGooglePayConfigString),
                paymentItems: _paymentItems,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
