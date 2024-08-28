import 'package:bookstore/Data%20Layer/bookStoreApiCall.dart';
import 'package:bookstore/Providers/CartStateProvider.dart';
import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:bookstore/global/common/InputTextFieldComp.dart';
import 'package:bookstore/global/common/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addressform extends StatefulWidget {
  const Addressform({super.key});

  @override
  State<Addressform> createState() => _AddressformState();
}

class _AddressformState extends State<Addressform> {
  int _groupValue = 0;
TextEditingController _nameControler = TextEditingController();
TextEditingController _phoneControler = TextEditingController();
TextEditingController _pincodeControler = TextEditingController();
TextEditingController _localityControler = TextEditingController();
TextEditingController _addressControler = TextEditingController();
TextEditingController _cityControler = TextEditingController();
TextEditingController _LandmarkControler = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _nameControler.dispose();
    super.dispose();
  }
  Bookstoreapicall _bookstoreapicall = Bookstoreapicall();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 18),
              child: Text(
                "Coustomer Details",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Inputtextfieldcomp(controller: _nameControler, hintText: "Name"),
            Inputtextfieldcomp(
                controller: _phoneControler, hintText: "Phone number"),
            Inputtextfieldcomp(controller: _pincodeControler, hintText: "Pincode"),
            Inputtextfieldcomp(controller: _addressControler, hintText: "Address"),
            Inputtextfieldcomp(
                controller: _localityControler, hintText: "Locality"),
            Inputtextfieldcomp(
                controller: _cityControler, hintText: "City/Town"),
            Inputtextfieldcomp(controller: _LandmarkControler, hintText: "State"),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 1),
              child: Text(
                "Type",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      activeColor: brown,
                      value: 0,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value as int;
                        });
                      },
                    ),
                    Text('Home'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: brown,
                      value: 1,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value as int;
                        });
                      },
                    ),
                    Text('Work'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: brown,
                      value: 2,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value as int;
                        });
                      },
                    ),
                    Text('Other'),
                  ],
                ),
              ],
            ),
            ButtonComp(title: "ADD", buttonAction: () async{
              String type=''; 
              switch (_groupValue) {
                case 1:
                  type= 'Work';
                  break;
                case 2:
                  type= 'Other';
                  break;
                default:
                  type= 'Home';
              }
              bool stat= await _bookstoreapicall.EditAddress(type, '${_addressControler.text}, ${_localityControler.text} - ${_pincodeControler.text}', _cityControler.text, _LandmarkControler.text);
              if (stat) {
                final _bookcount = Provider.of<Cartstateprovider>(context, listen: false); 
                _bookcount.statechange();
              Navigator.pop(context);  
              }
              })
          ],
        ));
  }
}
