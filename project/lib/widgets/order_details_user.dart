import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/user_select_location.dart';
import 'package:project/widgets/cart_item.dart';
import 'package:project/widgets/delivery_page.dart';

class orederDetailsUSer extends StatelessWidget {
  final String deliveryOption;
  final int productId;

  const orederDetailsUSer(
      {super.key, required this.deliveryOption, required this.productId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF063A4E),
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Shipping Address',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color(0xFF063A4E),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              items: ['Palestaine', 'Jorden', 'lebanon', 'syriya']
                  .map((location) => DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'First Name*',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Last Name*',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number*',
                hintText: 'PL +970',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 8.0),
            Text(
              'Need Correct Phone Number for delivery.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'City*',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Street Address*',
                hintText: 'Street Name, House No, Apt, suite etc.',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'OR you can choose your Location from the map',
              style: TextStyle(
                  color: const Color.fromARGB(255, 18, 18, 18), fontSize: 15),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                //minimumSize: Size(90, 40),
                //padding: EdgeInsets.symmetric(horizontal: 5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: Icon(
                FontAwesomeIcons.mapMarkerAlt,
                size: 30,
                color: Color(0xFF063A4E),
              ),
              onPressed: () {
                Get.to(() => userSelectLocation());
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (!CartItemState.flagIsOrder) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return DeliveryPage(
                        isFree: true,
                        deliveryOption: deliveryOption,
                        productId: productId,
                        onPaymentSuccess: () {},
                      );
                    },
                  );
                } else if (CartItemState.flagIsOrder) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return DeliveryPage(
                        isFree: false,
                        deliveryOption: deliveryOption,
                        productId: productId,
                        onPaymentSuccess: () {},
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(50, 25),
                backgroundColor: Color(0xFF063A4E),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
              ),
              child: Text(
                "Save",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  fontSize: 21,
                ),
              ),
            ),
            /* ElevatedButton(
              onPressed: () {
                // Implement your save functionality here
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 16.0),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
