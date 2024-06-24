import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database.dart';
import '../fuel_data_model.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController meterController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String _fuelType = 'Petrol'; // Default fuel type

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    meterController = TextEditingController();
    rateController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text("Add record"), surfaceTintColor: Colors.green,shadowColor: Colors.green,backgroundColor: Colors.green,),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.green, Colors.blueAccent],
                  begin: Alignment(0, 1),
                  end: Alignment(0.00, -1.00),)),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 48.0, left: 20, right: 20, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    buildTextFormField(meterController, "Last Meter Reading"),
                    const SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(
                        rateController, "Price of Petrol/Diesel/CNG"),
                    const SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(amountController, "Amount paid"),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          activeColor: Colors.white,
                          value: 'Petrol',
                          groupValue: _fuelType,
                          onChanged: (value) {
                            setState(() {
                              _fuelType = value!;
                            });
                          },
                        ),
                        const Text(
                          "Petrol",
                          style: TextStyle(color: Colors.white),
                        ),
                        Radio<String>(
                          activeColor: Colors.white,
                          value: 'CNG',
                          groupValue: _fuelType,
                          onChanged: (value) {
                            setState(() {
                              _fuelType = value!;
                            });
                          },
                        ),
                        const Text(
                          "CNG",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                InkWell(
                  onTap: () async {
                    if (meterController.text.isEmpty ||
                        rateController.text.isEmpty ||
                        amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Fill the details!"),
                      ));
                    } else {
                      final String currentDate =
                          DateFormat('dd-MM-yyyy').format(DateTime.now());

                      final fuelData = FuelData(
                        meter: double.parse(meterController.text),
                        rate: double.parse(rateController.text),
                        amount: double.parse(amountController.text),
                        date: currentDate,
                        fuelType: _fuelType,
                      );
                      await DatabaseHelper().insertFuelData(fuelData);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: (meterController.text.isEmpty ||
                                rateController.text.isEmpty ||
                                amountController.text.isEmpty)
                            ? Colors.white54
                            : Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text("Submit",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white))),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      TextEditingController editingController, String label) {
    return TextFormField(
      controller: editingController,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      onChanged: (value) {
        setState(() {
          editingController.text = value.toString();
        });

        print(meterController.text);
      },
      decoration: InputDecoration(
        focusColor: Colors.white,
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.white54.withOpacity(0.2), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
